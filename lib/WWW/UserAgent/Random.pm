package WWW::UserAgent::Random;

use 5.008008;
use strict;
use warnings;

use vars qw($VERSION @ISA @EXPORT $LIBRARY);

use Exporter ();
@ISA = qw(Exporter);
@EXPORT = qw(rand_ua);

$VERSION = '0.02';
$LIBRARY = __PACKAGE__;

$|=1;

sub rand_ua {
	my $agent = shift || "";

	my %agents = (
		linux   => [ 
			"Emacs-W3/4.0pre.46 URL/p4.0pre.46 (i686-pc-linux; X11)",
			"Links (2.2; Linux 2.6.25-gentoo-r9 sparc64; 166x52)",
			"Mozilla/5.0 (compatible; Konqueror/4.0; Linux) KHTML/4.0.82 (like Gecko)",
			"Mozilla/5.0 (compatible; Konqueror/4.1; Linux 2.6.27.7-134.fc10.x86_64; X11; x86_64) KHTML/4.1.3 (like Gecko) Fedora/4.1.3-4.fc10",
			"Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.1.16) Gecko/20080716 (Gentoo) Galeon/2.0.6",
			"Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.0.4) Gecko/20060627 Galeon/2.0.1",
			"Mozilla/5.0 (X11; U; Linux ppc; en-US; rv:1.8.1.13) Gecko/20080313 Iceape/1.1.9 (Debian-1.1.9-5)",
			"Mozilla/5.0 (X11; U; Linux sparc64; en-GB; rv:1.8.1.11) Gecko/20071217 Galeon/2.0.3 Firefox/2.0.0.11",
			"Mozilla/5.0 (X11; U; Linux sparc64; en-GB; rv:1.8.1.11) Gecko/20071217 Galeon/2.0.3 Firefox/2.0.0.11",
			"Mozilla/5.0 (X11; U; Linux x86_64; en; rv:1.9.0.1) Gecko/20080528 Epiphany/2.22 Firefox/3.0",
			"Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.0.5) Gecko/2008122903 Gentoo Iceweasel/3.0.5",
			"Opera/5.0 (Linux 2.0.38 i386; U) [en]",
			"Opera/6.x (Linux 2.4.8-26mdk i686; U) [it]",
			"Seamonkey-1.1.13-1(X11; U; GNU Fedora fc 10) Gecko/20081112",
		],
		macintosh => [
			"iCab/4.0 (Macintosh; U; Intel Mac OS X)",
			"Mozilla/4.0 (compatible; MSIE 5.23; Mac_PowerPC)",
			"Mozilla/5.0 (Macintosh; U; Intel Mac OS X 10_5_6; en-gb) AppleWebKit/528.10+ (KHTML, like Gecko) Version/4.0dp1 Safari/526.11.2",
			"Mozilla/5.0 (Macintosh; U; Intel Mac OS X 10_5_6; fr-fr) AppleWebKit/525.27.1 (KHTML, like Gecko) Version/3.2.1 Safari/525.27.1",
			"Mozilla/5.0 (Macintosh; U; Intel Mac OS X 10.5; en-US; rv:1.9.0.1) Gecko/2008070206",
			"Mozilla/5.0 (Macintosh; U; PPC Mac OS X Mach-O; en-US; rv:1.8b) Gecko/20050217",
			"Mozilla/5.0 (Macintosh; U; PPC Mac OS X 10.4; en-GB; rv:1.9b5) Gecko/2008032619 Firefox/3.0b5",
			"Mozilla/5.0 (Macintosh; U; PPC Mac OS X Mach-O; en-US; rv:1.5) Gecko/20031026 Firebird/0.7",
			"Mozilla/5.0 (Macintosh; U; PPC Mac OS X Mach-O; en-US; rv:1.3a) Gecko/20030101 Phoenix/0.5",
			"Mozilla/5.0 (Macintosh; U; PPC Mac OS X; ja-jp) AppleWebKit/419 (KHTML, like Gecko) Shiira/1.2.3 Safari/125",
			"Mozilla/5.0 (Macintosh; U; PPC Mac OS X Mach-O; en; rv:1.8.1.4pre) Gecko/20070511 Camino/1.6pre",
			"Mozilla/5.0 (X11; U; Linux ppc; en-US; rv:1.9a8) Gecko/2007100620 GranParadiso/3.1",
			"Opera/9.61 (Macintosh; Intel Mac OS X; U; de) Presto/2.1.1",
		],
		windows => [
			"Mozilla/3.0 (compatible; Opera/3.0; Windows 3.1) v3.1",
			"Mozilla/3.0 (compatible; Opera/3.0; Windows 95/NT4) 3.2",
			"Mozilla/4.0 (compatible; Lotus-Notes/5.0; Windows-NT)",
			"Mozilla/4.0 (compatible; MSIE 8.0; Windows NT 6.1; Trident/4.0; SLCC2; .NET CLR 2.0.50727; .NET CLR 3.5.30729; .NET CLR 3.0.30729; Media Center PC 6.0; .NET CLR 3.0.04506; Media Center PC 5.0; SLCC1; Tablet PC 2.0)",
			"Mozilla/4.0 (compatible; MSIE 6.0; U; Windows;) Lobo/0.98.2",
			"Mozilla/4.0 (compatible; MSIE 6.0b; Windows 98)",
			"Mozilla/4.0 (compatible; MSIE 7.0; Windows NT 6.0;)",
			"Mozilla/4.0 (compatible; MSIE 7.0; Windows NT 5.1; .NET CLR 2.0.50727; .NET CLR 3.0.4506.2152; .NET CLR 3.5.30729) Sleipnir/2.8.3",
			"Mozilla/5.0 (compatible; Konqueror/4.0; Windows) KHTML/4.0.83 (like Gecko)",
			"Mozilla/5.0 (Windows; U; Win95; en-US; rv:1.5) Gecko/20031007 Firebird/0.7",
			"Mozilla/5.0 (Windows; U; Win98; en-US; rv:1.3a) Gecko/20021207 Phoenix/0.5",
			"Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.9.2a1pre) Gecko",
			"Mozilla/5.0 (Windows; U; Windows NT 6.0; en-US; rv:1.8.1.8pre) Gecko/20070928 Firefox/2.0.0.7 Navigator/9.0RC1",
			"Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.9.1b3pre) Gecko/20081208 SeaMonkey/2.0a3pre",
			"Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.9a7) Gecko/2007080210 GranParadiso/3.0a7",
			"Mozilla/5.0 (Windows; U; Windows NT 6.0; en-US) AppleWebKit/528.10 (KHTML, like Gecko) Chrome/2.0.157.2 Safari/528.10",
			"Opera/9.63 (Windows NT 5.2; U; en) Presto/2.1.1",
		],
		openbsd => [
			"Mozilla/5.0 (compatible; Konqueror/3.5; OpenBSD) KHTML/3.5.9 (like Gecko)",
			"Mozilla/5.0 (X11; U; OpenBSD amd64; en; rv:1.8.1.6) Gecko/20070817 Epiphany/2.18 Firefox/2.0.0.6",
			"Mozilla/5.0 (X11; U; OpenBSD i386; en-US; rv:1.8.1.14) Gecko/20080821 Firefox/2.0.0.14",
		],
		freebsd => [
			"Mozilla/3.0 (WorldGate Gazelle 3.5.1 build 11; FreeBSD2.2.8-STABLE)",
			"Mozilla/4.76 [en] (X11; U; FreeBSD 4.4-STABLE i386)",
			"Mozilla/5.0 (compatible; Konqueror/3.2; FreeBSD) (KHTML, like Gecko)",
			"Mozilla/5.0 (X11; U; FreeBSD i386; en; rv:1.8.1.12) Gecko/20080213 Epiphany/2.20 Firefox/2.0.0.12",
			"Mozilla/5.0 (X11; U; FreeBSD i386; en-US; rv:1.6) Gecko/20040406 Galeon/1.3.15",
			"Mozilla/5.0 (X11; U; GNU/kFreeBSD i686; en-US; rv:1.8.1.16) Gecko/20080702 Iceape/1.1.11 (Debian-1.1.11-1)",
		],
		netbsd => [
			"ELinks (0.4.3; NetBSD 3.0.2_PATCH sparc64; 141x19)",
			"Mozilla/5.0 (compatible; Konqueror/3.5; NetBSD 4.0_RC3; X11) KHTML/3.5.7 (like Gecko)",
		],
		os2 => [
			"Links (2.1pre14; OS/2 1 i386; 80x33)",
			"Mozilla/5.0 (OS/2; U; Warp 4.5; en-US; rv:1.8.1.3pre) Gecko/20070307 SeaMonkey/1.1.1+",
		],
		beos => [
			"Mozilla/5.0 (BeOS; U; BeOS BePC; en-US; rv:1.9a1) Gecko/20051002 Firefox/1.6a1",
			"Mozilla/5.0 (BeOS; U; BeOS BePC; en-US; rv:1.9a1) Gecko/20060702 SeaMonkey/1.5a",
		],
		sunos => [
			"Mozilla/5.0 (compatible; Konqueror/3.5; SunOS) KHTML/3.5.0 (like Gecko)",
			"Mozilla/5.0 (X11; U; SunOS sun4u; en-US; rv:1.7.5) Gecko/20050105 Epiphany/1.4.8",
		],
		crawlers => [
			"Bimbot/1.0",
			"btbot/0.4 (+http://www.btbot.com/btbot.html)",
			"DiamondBot",
			"Gigabot/3.0 (http://www.gigablast.com/spider.html)",
			"Googlebot/2.1 (+http://www.googlebot.com/bot.html)",
			"Googlebot-Image/1.0",
			"htdig/3.1.6 (unconfigured\@htdig.searchengine.maintainer)",
			"libwww-perl/5.808",
			"lwp-trivial/1.41",
			"Mnogosearch-3.1.21",
			"Mozilla/4.0 compatible ZyBorg/1.0 DLC (wn.zyborg\@looksmart.net; http://www.WISEnutbot.com)",
			"Mozilla/5.0 (compatible; Googlebot/2.1; +http://www.google.com/bot.html)",
			"Mozilla/5.0 (compatible; Yahoo! Slurp; http://help.yahoo.com/help/us/ysearch/slurp)",
			"msnbot/1.1 (+http://search.msn.com/msnbot.htm)",
			"psbot/0.1 (+http://www.picsearch.com/bot.html)",
			"PycURL/7.13.2",
			"Python-urllib/2.5",
			"YahooSeeker/1.2 (compatible; Mozilla 4.0; MSIE 5.5; yahooseeker at yahoo-inc dot com ; http://help.yahoo.com/help/us/shop/merchant/)",
			"zspider/0.9-dev http://feedback.redkolibri.com/",
		],
		link_checkers => [
			"Link Valet Online 1.1",
			"Link Validity Check From: http://www.w3dir.com/cgi-bin (Using: Hot Links SQL by Mrcgiguy.com)",
			"Mozilla/5.0 (compatible; LinksManager.com_bot http://linksmanager.com/linkchecker.html)",
			"Mojoo Robot (http://www.mojoo.com/)",
			"online link validator (http://www.dead-links.com/)",
			"InfoWizards Reciprocal Link System PRO - (http://www.infowizards.com)",
			"REL Link Checker Lite 1.0",
			"SiteBar/3.3.8 (Bookmark Server; http://sitebar.org/)",
			"Vivante Link Checker (http://www.vivante.com)",
			"W3C-checklink/4.3 [4.42] libwww-perl/5.805",
			"Xenu Link Sleuth 1.2i",
		],
		amiga => [
			"AmigaVoyager/3.2 (AmigaOS/MC680x0)",
			"AmigaVoyager/2.95 (compatible; MC680x0; AmigaOS)",
			"Mozilla/3.01 (compatible; AmigaVoyager/2.95; AmigaOS/MC680x0)",
			"Mozilla/4.0 (compatible; AWEB 3.4 SE; AmigaOS)",
		],
		others => [
			"Dillo/0.8.6",
			"Lynx/2.8.6rel.4 libwww-FM/2.14 SSL-MM/1.4.1 GNUTLS/1.6.3",
			"Lynx/2.8.7dev.9 libwww-FM/2.14",
			"Links (6.9; Unix 6.9-astral sparc; 80x25)",
			"Mozila/5.0 (iPod; U; CPU like Mac OS X; en)",
			"Mozilla/1.10 [en] (Compatible; RISC OS 3.70; Oregano 1.10)",
			"w3m/0.5.2",
		],
		validators => [
			"CSE HTML Validator Lite Online (http://online.htmlvalidator.com/php/onlinevallite.php)",
			"CSSCheck/1.2.2",
			"Cynthia 1.0",
			"HTMLParser/1.6",
			"P3P Validator",
			"Jigsaw/2.2.5 W3C_CSS_Validator_JFouffa/2.0",
			"W3C_Validator/1.555",
			"WDG_Validator/1.6.2",
		],
		feed_readers => [
			"Bloglines/3.1 (http://www.bloglines.com)",
			"everyfeed-spider/2.0 (http://www.everyfeed.com)",
			"FeedFetcher-Google; (+http://www.google.com/feedfetcher.html)",
			"Gregarius/0.5.2 (+http://devlog.gregarius.net/docs/ua)",
		],
		phones  => [
			"BlackBerry7520/4.0.0 Profile/MIDP-2.0 Configuration/CLDC-1.1 UP.Browser/5.0.3.3 UP.Link/5.1.2.12 (Google WAP Proxy/1.0)",
			"Firefox (iPhone; U; CPU like Mac OS X; en)",
			"Mobile Safari 1.1.3 (iphone; U; CPU like Mac OS X;en)",
			"Mozilla/5.0 (iPhone; U; CPU like Mac OS X; en) AppleWebKit/420+ (KHTML, like Gecko) Version/3.0 Mobile/1A535b Safari/419.3",
			"Nokia7110/1.0 (05.01) (Google WAP Proxy/1.0)",
		],
		consoles  => [
			"wii libnup/1.0",
			"Mozilla/5.0 (PLAYSTATION 3; 2.00)",
			"PSP (PlayStation Portable); 2.00",
		],
		proxy  => [
			"BlueCoat ProxySG",
			"Nitroglobal Anonymous Proxy",
			"SmallProxy 3.2 Beta 20",
		],
	);

	unless ($agents{$agent}){
	my @array = keys %agents;
		$agent = $array[ rand @array ];	
	}
	
	if ($agent =~ /^browsers$/){
		my @array = ['linux','macintosh','windows','openbsd','freebsd','netbsd','os2','beos','sunos','amiga','others','phones','consoles'];
		$agent = $array[ rand @array ];
	}

	my $rarray = scalar @{$agents{$agent}};
	$rarray = int(rand($rarray));
	my $ua = $agents{$agent}[$rarray];
	return $ua;
}

1;
__END__

=head1 NAME

WWW::UserAgent::Random - Perl extension to generate random User Agent

=head1 SYNOPSIS

  use WWW::UserAgent::Random;

  my $user_agent = rand_ua("macintosh");

=head1 DESCRIPTION

WWW::UserAgent::Random allows to generate random User Agent.

If you don't specify a category (linux, macintosh, windows, openbsd, freebsd, netbsd, os2, beos, sunos, crawlers, link_checkers, amiga, others, validators, feed_readers, phones, consoles, proxy, browsers), then the rand_ua function will return ones random.

The category 'browsers' includes all browsers in other categories, but not robots.

=head1 SEE ALSO

http://en.wikipedia.org/wiki/User_agent

=head1 AUTHOR

Matteo Cantoni, E<lt>matteo.cantoni@nothink.org<gt>

=head1 COPYRIGHT AND LICENSE

Copyright (C) 2009,2010 by Matteo Cantoni

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself, either Perl version 5.8.8 or,
at your option, any later version of Perl 5 you may have available.

=cut
