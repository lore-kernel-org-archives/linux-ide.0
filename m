From: "I Stratford" <i.d.stratford@gmail.com>
Subject: Promise SATA TX4 300 port timeout with sata_promise in 2.6.22, kernel panic in 2.6.23
Date: Sat, 10 Nov 2007 04:43:04 -0800
Message-ID: <6f048fc10711100443y6e9982b9jc00b3740f0a44d79@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_Part_8999_24453149.1194698584081"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from py-out-1112.google.com ([64.233.166.183]:4595 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751793AbXKJMnF (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 10 Nov 2007 07:43:05 -0500
Received: by py-out-1112.google.com with SMTP id u77so197352pyb
        for <linux-ide@vger.kernel.org>; Sat, 10 Nov 2007 04:43:04 -0800 (PST)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

------=_Part_8999_24453149.1194698584081
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi there. I have read the archives quite a bit, but this is my first
post to linux-ide or any kernel-related mailing list. I therefore
apologize in advance if any aspect of the form or content of my mail
is in any way inappropriate for the list! :)

I have a desktop with the following (admittedly somewhat insane) configuration :

- ASUS K8NE-Deluxe Motherboard (2x vanilla SATA and 4x sil3112
onboard, NForce3 PCI)
- 2  Promise TX4 150 pci cards, connected to 8 250gb SATA seagate
drives (ST3250823AS)
- 2  Promise TX4 300 pci cards, connected to 8 500gb SATA hitachi
drives (HDT725050VLA360)

This provides me with a total of 22 SATA ports, 16 of which use the
sata_promise driver. Prior to the most recent upgrade which added the
2 TX4 300s, I have been using the 2 promise TX4 150s with the on-board
SATA ports as the underlying drives for linux software raid 5 as linux
mds. This configuration has been running fine in linux kernels
throughout the 2.6 series, and works in all cases if they are the only
powered drives in the machine.

I began to experience trouble when I added the 2 Promise TX4 300 cards
with the hitachi drives attached. I experienced "port slow to respond"
resets on the TX4 300 connected drives, especially of a specific port
(sdu), while using a (fedora-patched) 2.6.22 kernel. I debugged all of
the possible hardware related causes, specifically ruling out cabling,
SATA port and hard drive failure by swapping each component and
experiencing the same timeout behavior with each.

If I had all 8 drives assembled into a RAID, the timeouts would occur
before or shortly after the re-sync completed. Strangely, the timeouts
did not seem to happen when I had only 7 of the 8 drives assembled
into the RAID5, even if all 8 were physically connected. The timeouts
appeared to be unrelated to reads or writes, because they would happen
even when the RAID5 was synced and not experiencing any usage.

In most cases, it was "sdu", aka "ata22" which "failed" :
"
Oct 29 00:08:01 rice kernel: ata22.00: exception Emask 0x0 SAct 0x0
SErr 0x1380000 action 0x2 frozen
Oct 29 00:08:01 rice kernel: ata22.00: cmd
25/00:78:bf:c5:b7/00:00:32:00:00/e0 tag 0 cdb 0x0 data 61440 in
Oct 29 00:09:12 rice kernel: res 40/00:00:00:00:00/00:00:00:00:00/00
Emask 0x4 (timeout)
Oct 29 00:09:12 rice kernel: ata22: port is slow to respond, please be
patient (Status 0xff)
Oct 29 00:09:12 rice kernel: ata22: device not ready (errno=-16),
forcing hardreset
Oct 29 00:09:13 rice kernel: ata22: hard resetting port
Oct 29 00:09:13 rice kernel: ata22: port is slow to respond, please be
patient (Status 0xff)
Oct 29 00:09:13 rice kernel: ata22: COMRESET failed (errno=-16)
"

If the system remained running in this state, other ports would
sometimes time out, even including ports on the original TX150s. This
was the only case in which I saw ports on the TX150s appear to time
out. I chalk this up to linux not liking it when any drive is hung for
an extended period of time, and only mention it in case the
information might be in some way useful.

After experiencing these problems for a while and running out of
obvious hardware-based explanations, I started searching the linux-ide
archives and found this post :

http://www.spinics.net/lists/linux-ide/msg14089.html

In which Mikael Pettersson suggests using one of his sata_promise
hacks to step the TX4 300 to 1.5Gbps mode by forcing SControl and
Peter Favrholdt suggests that this worked for him in 2.6.21.
Follow-ups to the thread indicated that this problem was largely fixed
in 2.6.23 and, as 2.6.23 had been packaged for FC7 in the interim, I
installed it with high hopes.

Unfortunately, 2.6.23 (2.6.23.1-21.fc7) kernel panics when interacting
with the 8 drive array on the new TX4 300s. Strangely, the panic
seemed to be in md2_raid5 and associated raid system calls ("release
stripe" iirc). With reiserfs on the raid, it would happen at mount
time. It also kernel panicked when I tried to mkfs.xfs. I also tried
Mikael Pettersson's "force to 1.5Gbps" patches for 2.6.23 patched into
2.6.23.1-21.fc7, with the same kernel-panic result.

I then decided to take a shot at 2.6.22 (2.6.22.9-91.fc7) with the
1.5GBps patch, and have been running with no problems on the RAID ever
since. This is too sweet, so I have been keeping my fingers crossed.
Without the patch, problems appear within minutes or hours. With the
patch, it has been running for three days with no problems whatsoever,
even with heavy usage.

The purpose of the mail is to document and share my experience in the
hope that someone might find it useful, either for debugging their own
TX4 300-centric system issues or figuring out what is up with
sata_promise and the TX4 300 in 3Gbps mode. I also wish to offer my
somewhat unique promise-based system as a test environment for either
the timeout or kernel panic issues. I obviously have some basic need
for data integrity of the RAID5, but this system is not in production
and is therefore more available for testing purposes than the average
machine with 22 Promise SATA ports..  :)

Thank you all very much for your dedicated work on controller support
in linux, and please let me know if you need any further information
or if I can help in any way.

___ids
PS - attached is a copy of /proc/interrupts, fyi.

------=_Part_8999_24453149.1194698584081
Content-Type: text/plain; name=interrupts.txt
Content-Transfer-Encoding: base64
X-Attachment-Id: f_f8u43fbr
Content-Disposition: attachment; filename=interrupts.txt

ICAgICAgICAgICBDUFUwDQogIDA6ICAgICAgICAxODAgICBJTy1BUElDLWVkZ2UgICAgICB0aW1l
cg0KICAxOiAgICAgICAgICAyICAgSU8tQVBJQy1lZGdlICAgICAgaTgwNDINCiAgNTogICAgICAg
ICAgMCAgIElPLUFQSUMtZWRnZSAgICAgIE1QVTQwMSBVQVJUDQogIDY6ICAgICAgICAgIDYgICBJ
Ty1BUElDLWVkZ2UgICAgICBmbG9wcHkNCiAgODogICAgICAgICAgMSAgIElPLUFQSUMtZWRnZSAg
ICAgIHJ0Yw0KICA5OiAgICAgICAgICAwICAgSU8tQVBJQy1mYXN0ZW9pICAgYWNwaQ0KIDEyOiAg
ICAgICAgMTA0ICAgSU8tQVBJQy1lZGdlICAgICAgaTgwNDINCiAxNDogICAgIDU4Nzc2MyAgIElP
LUFQSUMtZWRnZSAgICAgIGxpYmF0YQ0KIDE1OiAgICAgICAgICAwICAgSU8tQVBJQy1lZGdlICAg
ICAgbGliYXRhDQogMTY6ICAgICAgNDIxNjQgICBJTy1BUElDLWZhc3Rlb2kgICBvaGNpX2hjZDp1
c2IxLCBzYXRhX252DQogMTc6ICAgNDE1NTg2NzAgICBJTy1BUElDLWZhc3Rlb2kgICBvaGNpX2hj
ZDp1c2IyLCBldGgwDQogMTg6ICAgIDcxMzI3NzUgICBJTy1BUElDLWZhc3Rlb2kgICBlaGNpX2hj
ZDp1c2IzLCBOVmlkaWEgQ0s4Uw0KIDE5OiAgIDE4OTc3NjMwICAgSU8tQVBJQy1mYXN0ZW9pICAg
c2F0YV9zaWwsIHNhdGFfcHJvbWlzZQ0KIDIwOiAgMTg3OTU5MjUyICAgSU8tQVBJQy1mYXN0ZW9p
ICAgc2F0YV9wcm9taXNlLCBldGgxDQogMjE6ICAgICAyNTAxNTAgICBJTy1BUElDLWZhc3Rlb2kg
ICBzYXRhX3Byb21pc2UNCiAyMjogICAxNDc2MjY2MyAgIElPLUFQSUMtZmFzdGVvaSAgIHNhdGFf
cHJvbWlzZQ0KTk1JOiAgICAgICAgICAwDQpMT0M6ICAgMTg2NjI2NzgNCkVSUjogICAgICAgICAg
MQ0KTUlTOiAgICAgICAgICAwDQo=
------=_Part_8999_24453149.1194698584081--
