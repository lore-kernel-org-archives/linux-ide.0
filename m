From: "B. M. Shea" <imbshea-spam@yahoo.com>
Subject: VIA and /dev/sdX <---> /dev/hdX with 2.6
Date: Wed, 21 Jul 2004 14:24:37 -0500
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <40FEC2F5.20605@yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp811.mail.sc5.yahoo.com ([66.163.170.81]:38775 "HELO
	smtp811.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S266604AbUGUT1Q (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 21 Jul 2004 15:27:16 -0400
List-Id: linux-ide@vger.kernel.org
To: Linux IDE Mailing List <linux-ide@vger.kernel.org>



Dear LINUX-IDE,

I have burned a new ISO for the Slackware v10 crowd(and a boot disk for 
that matter) to use SATA. It is simply "libata" patched against 2.4.26 
(default kernel for Slack v10 install). It automatically installs the 
kernel with the patch (This and a few minor script changes were really 
the only changes I made.)
Anyway, it is working flawlessly unless you have the VIA chipset and 
start using a 2.6.x kernel. People with VIA (specifically) have been 
having the device change from /dev/sdX to /dev/hdX. after compiling a 
new kernel to use VIA as a Low level SCSI driver.

I have examined a couple of their CONFIG's and haven't seen any problems 
with that. Is this a known 'condition' in these kernels? Jeff do you 
know anything about this? I know I have written you on this before, but 
for the life of me, I cannot find any info on this anywhere on the web. 
Just stuff about what I just described and how people can't seem to fix 
it. The drives seems to 'work' after being discovered as HD 
devices...But on other forums I have read they tend to be 'unreliable' - 
whatever that means. I have told them to try the 'boot: 
noprobe=/dev/hde' option, but I am not sure if this has let libata 
discover them as SCSI...(I haven't heard back from anyone yet about 
this.) Any idea's or have I missed some important information on the 2.6 
kernel somewhere?

Sincerely,

Brady Shea



-- 
-Sig:-
PGP/GPG Key [Server Lookup]:
0x06E3769E22BB70A7
or just go here:
http://pgp.mit.edu:11371/pks/lookup?op=get&search=0x22BB70A7
-End of Signature-
