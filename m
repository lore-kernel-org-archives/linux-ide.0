From: Michael Buesch <fsdeveloper@yahoo.de>
Subject: Re: [2.6] system is very slow during disk access
Date: Wed, 6 Aug 2003 21:29:34 +0200
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <200308062129.47113.fsdeveloper@yahoo.de>
References: <200308062052.10752.fsdeveloper@yahoo.de>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp012.mail.yahoo.com ([216.136.173.32]:19217 "HELO
	smtp012.mail.yahoo.com") by vger.kernel.org with SMTP
	id S270925AbTHFT3p convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 6 Aug 2003 15:29:45 -0400
In-Reply-To: <200308062052.10752.fsdeveloper@yahoo.de>
Content-Description: clearsigned data
Content-Disposition: inline
List-Id: linux-ide@vger.kernel.org
To: linux kernel mailing list <linux-kernel@vger.kernel.org>
Cc: linux-ide@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On Wednesday 06 August 2003 20:51, Michael Buesch wrote:
> Hi.
>
> I have massive problems with linux-2.6.0-test2.
> When some process writes something to disk, it's very hard
> to go on working with the system.
>
> Some test-szenario:
> $ dd if=3D/dev/zero of=3D./test.file
>
> While dd is running, xmms skips playing every now and then
> and the mouse is near to be unusable. The Mouse-cursor
> behaves some kind of very lazy and some times it jumps
> from one point on the display to another.
> When I stop disk-access, it works again quite fine.
>
> Would be cool, if you could give me some point to start
> for tracking this down.
>
> Please CC me, as I'm not subscribed to linux-ide. Thanks.

I sould add some things:

I'm using ReiserFS.

I've made a test-run without X in the console now.
I started this program on tty0, to see if there are big skips or
something like that:

int main()
{
	while (1) {
		printf("jkhdsjklhfkjfhsdjkhjbghghjghjjh");
		printf("jsdl=F6kflsm,dfowekcldfqw");
		printf("JKjhdsjkfhsnsdjkhJhjkhjkbmnxbuihjknlk");
		printf("kcjkld");
	}
	return 0;
}

When the machine isn't doing any disk-access, the "garbage-printing"
to the console, produced by the program above is very smooth.
But when I start dd on another tty, massive skips and breaks occur
to the output of the nice program above.
These are not small skips and breaks.
The system is quite unusable during running dd, because it doesn't
respond as it should.

I just tried to run the test-scenario on my other Linux-installation
on this machine with kernel 2.4.10 and there the output of the program
was quite smooth, even it dd was running und the system was still usabl=
e.

- --=20
Regards Michael Buesch  [ http://www.8ung.at/tuxsoft ]
Penguin on this machine:  Linux 2.6.0-test2 - i386

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE/MVcnoxoigfggmSgRAsg/AJ0dsfySPGpiOXFhA67gi580G/XaswCeNd4u
lVmXAvLHvcYIATgtuPHF4FU=3D
=3Dgh4Q
-----END PGP SIGNATURE-----

