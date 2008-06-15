From: Piter PUNK <piterpunk@slackware.com>
Subject: Re: Regression: kernel 2.6.24{,.1} ahci problem, does not boot (fwd)
Date: Sat, 14 Jun 2008 21:11:03 -0700 (PDT)
Message-ID: <Pine.LNX.4.63.0806142107420.17215@bob.slackware.com>
Mime-Version: 1.0
Content-Type: MULTIPART/Mixed; BOUNDARY="960504422-1551803131-1213498815=:2761"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from slackware.com ([64.57.102.34]:34671 "EHLO bob.slackware.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750906AbYFOEvS (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 15 Jun 2008 00:51:18 -0400
Content-ID: <Pine.LNX.4.63.0806142107421.17215@bob.slackware.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com
Cc: linux-ide@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--960504422-1551803131-1213498815=:2761
Content-Type: TEXT/PLAIN; CHARSET=US-ASCII; FORMAT=flowed
Content-ID: <Pine.LNX.4.63.0806142107422.17215@bob.slackware.com>


Sorry,

my last mail i forgot to see the MAINTAINERS file and send
only to LKML and to Tejun Heo.

-----forwarded mail below----------------------------------

Hi,

I have a notebook with SiS968. It works with 2.6.23.x
kernels but not with 2.6.24+ kernels. Probably my
problem is the same of this old thread:

http://lkml.org/lkml/2008/2/14/263

The error is exactly the same.

Looking the changes from 2.6.23 to 2.6.24 in

http://kernelnewbies.org/Linux_2_6_24#head-f29764e7ef293be84e2f8aa1b08b8816b15ebfca

I try to revert two commits to see which one brokes
my SATA device support. The guilt is this one:

http://git.kernel.org/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commit;h=7d50b60b5e38f910ad69f0187af00f5d6a8970d4

It implements PMP support. In attached patch, I
disable PMP support in ahci.c to SiS SATA controllers.

I hope i am sending the patch to correct place and
it works fine to others (well, it's working to me).

The patch is against 2.6.24.5, but i think it's easy
to adapt to 2.6.25+

Thanks

Piter PUNK
--960504422-1551803131-1213498815=:2761
Content-Type: TEXT/PLAIN; CHARSET=US-ASCII; NAME=sis96x_nopmp.patch
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.4.63.0806142000150.2761@bob.slackware.com>
Content-Description: 
Content-Disposition: ATTACHMENT; FILENAME=sis96x_nopmp.patch

LS0tIGxpbnV4LTIuNi4yNC41L2RyaXZlcnMvYXRhL2FoY2kuYwkyMDA4LTA0
LTE4IDIyOjUzOjM5LjAwMDAwMDAwMCAtMDMwMA0KKysrIGxpbnV4LTIuNi4y
NC41X3Npcy1maXhlZC9kcml2ZXJzL2F0YS9haGNpLmMJMjAwOC0wNi0xNCAy
Mjo1ODoyMi4wMDAwMDAwMDAgLTAzMDANCkBAIC04NSw2ICs4NSw3IEBADQog
CWJvYXJkX2FoY2lfaWduX2lmZXJyCT0gMiwNCiAJYm9hcmRfYWhjaV9zYjYw
MAk9IDMsDQogCWJvYXJkX2FoY2lfbXYJCT0gNCwNCisJYm9hcmRfYWhjaV9z
aXMJCT0gNSwNCiANCiAJLyogZ2xvYmFsIGNvbnRyb2xsZXIgcmVnaXN0ZXJz
ICovDQogCUhPU1RfQ0FQCQk9IDB4MDAsIC8qIGhvc3QgY2FwYWJpbGl0aWVz
ICovDQpAQCAtNDQyLDYgKzQ0MywxNSBAQA0KIAkJLnVkbWFfbWFzawk9IEFU
QV9VRE1BNiwNCiAJCS5wb3J0X29wcwk9ICZhaGNpX29wcywNCiAJfSwNCisJ
LyogYm9hcmRfYWhjaV9zaXMgKi8NCisJew0KKwkJQUhDSV9IRkxBR1MJKEFI
Q0lfSEZMQUdfTk9fUE1QKSwNCisJCS5mbGFncwkJPSBBSENJX0ZMQUdfQ09N
TU9OLA0KKwkJLmxpbmtfZmxhZ3MJPSBBSENJX0xGTEFHX0NPTU1PTiB8IEFU
QV9MRkxBR19IUlNUX1RPX1JFU1VNRSwNCisJCS5waW9fbWFzawk9IDB4MWYs
IC8qIHBpbzAtNCAqLw0KKwkJLnVkbWFfbWFzawk9IEFUQV9VRE1BNiwNCisJ
CS5wb3J0X29wcwk9ICZhaGNpX3Z0ODI1MV9vcHMsDQorCX0sDQogfTsNCiAN
CiBzdGF0aWMgY29uc3Qgc3RydWN0IHBjaV9kZXZpY2VfaWQgYWhjaV9wY2lf
dGJsW10gPSB7DQpAQCAtNTUyLDkgKzU2Miw5IEBADQogCXsgUENJX1ZERVZJ
Q0UoTlZJRElBLCAweDBhYmYpLCBib2FyZF9haGNpIH0sCQkvKiBNQ1A3OSAq
Lw0KIA0KIAkvKiBTaVMgKi8NCi0JeyBQQ0lfVkRFVklDRShTSSwgMHgxMTg0
KSwgYm9hcmRfYWhjaSB9LCAvKiBTaVMgOTY2ICovDQotCXsgUENJX1ZERVZJ
Q0UoU0ksIDB4MTE4NSksIGJvYXJkX2FoY2kgfSwgLyogU2lTIDk2NiAqLw0K
LQl7IFBDSV9WREVWSUNFKFNJLCAweDAxODYpLCBib2FyZF9haGNpIH0sIC8q
IFNpUyA5NjggKi8NCisJeyBQQ0lfVkRFVklDRShTSSwgMHgxMTg0KSwgYm9h
cmRfYWhjaV9zaXMgfSwgLyogU2lTIDk2NiAqLw0KKwl7IFBDSV9WREVWSUNF
KFNJLCAweDExODUpLCBib2FyZF9haGNpX3NpcyB9LCAvKiBTaVMgOTY4ICov
DQorCXsgUENJX1ZERVZJQ0UoU0ksIDB4MDE4NiksIGJvYXJkX2FoY2lfc2lz
IH0sIC8qIFNpUyA5NjggKi8NCiANCiAJLyogTWFydmVsbCAqLw0KIAl7IFBD
SV9WREVWSUNFKE1BUlZFTEwsIDB4NjE0NSksIGJvYXJkX2FoY2lfbXYgfSwJ
LyogNjE0NSAqLw0K

--960504422-1551803131-1213498815=:2761--
