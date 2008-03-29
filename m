From: "Sagar Borikar" <sagar.borikar@gmail.com>
Subject: Re: System reboots after insertion and removal of disks in 2.6.18 kernel
Date: Sat, 29 Mar 2008 23:17:27 +0530
Message-ID: <3fb94e50803291047x649f0405y8f1c164495e88606@mail.gmail.com>
References: <3fb94e50803281948v3e08df7fu2135ed1c113b5431@mail.gmail.com>
	 <47EE4913.6090202@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_Part_13225_13880208.1206812847272"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from py-out-1112.google.com ([64.233.166.179]:27121 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756927AbYC2Rr2 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 29 Mar 2008 13:47:28 -0400
Received: by py-out-1112.google.com with SMTP id u52so1148656pyb.10
        for <linux-ide@vger.kernel.org>; Sat, 29 Mar 2008 10:47:27 -0700 (PDT)
In-Reply-To: <47EE4913.6090202@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: linux-ide@vger.kernel.org

------=_Part_13225_13880208.1206812847272
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Thanks for your prompt reply Tejun.

On Sat, Mar 29, 2008 at 7:20 PM, Tejun Heo <htejun@gmail.com> wrote:
> Hello,
>
> Sagar Borikar wrote:

> > transition as well. So I get messages like COMRESET Failed and hard
> > reset failed. This doesn't happen if I insert back the drive
> > immediately. The system immediately recovers.
>
> Okay, that was one long paragraph.  :-)
>
> The behavior itself (sans triggering machine reset) is intended.  libata
> EH doesn't rely on the edge events (PHY status changed).  It relies on
> level state (PHY readiness) and as long as at least one PHY event is
> triggered after link status has changed, it doesn't care what polarity
> those events are or how many of them are.  That was the design decision
> made for robustness.

I understand. But the issue is, if I insert another drive, that event
gets detected. Only remove
event is not getting detected. So I was wondering if somehow I am able
to make the remove events detected, I can go ahead.Also digging
further in the code.
As expected in insert_remove action, the dev->class becomes
ATA_UNKNOWN and hence the ata_eh_revalidate_and_attach function
doesn't execute the following if condition
"action & ATA_EH_REVALIDATE && ata_dev_ready"
I am attaching two logs with remove and insert_remove files which
indicates the flow of the sequence in these two paths. IF you could
browse through that, would be great.

> > ata2: exception Emask 0x10 SAct 0x0 SErr 0x50000 action 0x2 frozen
> > ata2: hard resetting port
> > ata2: port is slow to respond, please be patient
> > ata2: port failed to respond (30 secs)  ---------------------> At this
> > state, actually the drive is removed. But not detected.
> > ata2: COMRESET failed (device not ready)
> > ata2: hardreset failed, retrying in 5 secs
> > ata2: hard resetting port
> > ata2: SATA link down (SStatus 0 SControl 310)
> > ata2: EH complete
>
> This is a quite old kernel, right?  Recent ones take much shorter to
> detect the condition.

That's right. It is 2.6.18

> > PMON2000 MIPS Initializing. Standby...
> > ERRORPC=bfc00004 CONFIG=0042e4bb STATUS=00400000
> > CPU PRID 000034c1, MaskID 00001320
> > Initializing caches...done (CONFIG=0042e4bb)
> > Switching to runtime address map...done
> > Setting up SDRAM controller: sdram config 0x80010000
> > master clock 100 Mhz, MulFundBIU 0x02, DivXSDRAM 0x02
> > sdram freq 0x09ef21aa hz, sdram period: 0x06 nsec
> > dimm0: density 256Mbit, width 16, single-sided, unbuffered, size
> > 0x08000000
> >  supported CAS latency: 2.5 2, using 2.5 cycles, byte18=0x0c
> >  RAS to CAS delay (tRCD) 0x12 nsec, byte29=0x
>
> Okay, and the machine got reboot.  It's weird that the reset happens
> *after* EH is complete.  After EH complete is printed, libata won't
> touch the hardware.  I'm sorry but I don't have any clue why the machine
> is getting rebooted.  Does the machine reset on oops?

Also it happens after say 1 to 1.5 minutes. If I insert drive within
this duration, reset doesn't happen. Also if I insert in any other
slot, reset doesn't happen. Only after immediate removal of the disk,
the reset happens.
Is there any way by which I can make the insertion event edge triggered?

Thanks in advance
Sagar
> --
> tejun
>

------=_Part_13225_13880208.1206812847272
Content-Type: text/plain; name=remove.txt
Content-Transfer-Encoding: base64
X-Attachment-Id: f_feeh3tqp0
Content-Disposition: attachment; filename=remove.txt

W3Jvb3RATkFTMDAxODAwMDEzMTBlIH5dIyBzaWxfaG9zdF9pbnRyOjENCnNpbF9ob3N0X2ludHI6
NCBhdGFfcG9ydF9mcmVlemUNCnNpbF9mcmVlemUgc3RhcnQNCnNpbF9mcmVlemUgZW5kDQphdGEx
IHBvcnQgZnJvemVuDQphdGFfYm1kbWFfZXJyb3JfaGFuZGxlcjogc3RhcnQNCmF0YV9kb19laCA6
IGF0YV9laF9hdXRvcHN5DQphdGFfZWhfYXV0b3BzeSA6IHN0YXJ0DQphdGFfZG9fZWggOiBhdGFf
ZWhfcmVwb3J0DQphdGExOiBleGNlcHRpb24gRW1hc2sgMHgxMCBTQWN0IDB4MCBTRXJyIDB4MTAw
MDAgYWN0aW9uIDB4MiBmcm96ZW4NCmF0YV9kb19laCA6IGF0YV9laF9yZWNvdmVyDQphdGFfZWhf
ZGV0YWNoX2RldiA6IHN0YXJ0DQphdGFfZWhfZGV0YWNoX2RldiA6IGF0YV9laF9wcmVwX3Jlc3Vt
ZQ0KYXRhX2VoX2RldGFjaF9kZXYgOiBhdGFfZWhfc2tpcF9yZWNvdmVyeQ0Kc2lsX2ZyZWV6ZSBz
dGFydA0Kc2lsX2ZyZWV6ZSBlbmQNCmF0YTEgcG9ydCBmcm96ZW4NCmF0YV9laF9kZXRhY2hfZGV2
IDogYXRhX2VoX3Jlc2V0DQphdGFfc3RkX3ByZXJlc2V0OiBzdGFydA0KYXRhMTogaGFyZCByZXNl
dHRpbmcgcG9ydA0KYXRhX3BvcnRfb2ZmbGluZSA6IHBvcnQgaXMgb2ZmbGluZQ0Kc2F0YV9wcmlu
dF9saW5rX3N0YXR1czpzdGFydA0KYXRhMTogU0FUQSBsaW5rIGRvd24gKFNTdGF0dXMgMCBTQ29u
dHJvbCAzMTApDQpzYXRhX3ByaW50X2xpbmtfc3RhdHVzOmVuZA0KYXRhX2VoX2RldGFjaF9kZXYg
OiBhdGFfZWhfdGhhd19wb3J0DQphdGFfZWhfZGV0YWNoX2RldiA6IGF0YV9laF9yZXZhbGlkYXRl
X2FuZF9hdHRhY2gNCmF0YV9wb3J0X29mZmxpbmUgOiBwb3J0IGlzIG9mZmxpbmUNCmF0YTE6IGZh
aWxlZCB0byByZWNvdmVyIHNvbWUgZGV2aWNlcywgcmV0cnlpbmcgaW4gNSBzZWNzDQphdGFfZWhf
ZGV0YWNoX2RldiA6IGF0YV9laF9wcmVwX3Jlc3VtZQ0KYXRhX2VoX2RldGFjaF9kZXYgOiBhdGFf
ZWhfc2tpcF9yZWNvdmVyeQ0Kc2lsX2ZyZWV6ZSBzdGFydA0Kc2lsX2ZyZWV6ZSBlbmQNCmF0YTEg
cG9ydCBmcm96ZW4NCmF0YV9laF9kZXRhY2hfZGV2IDogYXRhX2VoX3Jlc2V0DQphdGFfc3RkX3By
ZXJlc2V0OiBzdGFydA0KYXRhMTogaGFyZCByZXNldHRpbmcgcG9ydA0KbGNkb3V0OiBlcnJvciBy
ZXNwb25zZTogbmcNCmF0YV9wb3J0X29mZmxpbmUgOiBwb3J0IGlzIG9mZmxpbmUNCnNhdGFfcHJp
bnRfbGlua19zdGF0dXM6c3RhcnQNCmF0YTE6IFNBVEEgbGluayBkb3duIChTU3RhdHVzIDAgU0Nv
bnRyb2wgMzEwKQ0Kc2F0YV9wcmludF9saW5rX3N0YXR1czplbmQNCmF0YV9laF9kZXRhY2hfZGV2
IDogYXRhX2VoX3RoYXdfcG9ydA0KYXRhX2VoX2RldGFjaF9kZXYgOiBhdGFfZWhfcmV2YWxpZGF0
ZV9hbmRfYXR0YWNoDQphdGFfcG9ydF9vZmZsaW5lIDogcG9ydCBpcyBvZmZsaW5lDQphdGExOiBm
YWlsZWQgdG8gcmVjb3ZlciBzb21lIGRldmljZXMsIHJldHJ5aW5nIGluIDUgc2Vjcw0KYXRhX2Vo
X2RldGFjaF9kZXYgOiBhdGFfZWhfcHJlcF9yZXN1bWUNCmF0YV9laF9kZXRhY2hfZGV2IDogYXRh
X2VoX3NraXBfcmVjb3ZlcnkNCnNpbF9mcmVlemUgc3RhcnQNCnNpbF9mcmVlemUgZW5kDQphdGEx
IHBvcnQgZnJvemVuDQphdGFfZWhfZGV0YWNoX2RldiA6IGF0YV9laF9yZXNldA0KYXRhX3N0ZF9w
cmVyZXNldDogc3RhcnQNCmF0YTE6IGhhcmQgcmVzZXR0aW5nIHBvcnQNCmF0YV9wb3J0X29mZmxp
bmUgOiBwb3J0IGlzIG9mZmxpbmUNCnNhdGFfcHJpbnRfbGlua19zdGF0dXM6c3RhcnQNCmF0YTE6
IFNBVEEgbGluayBkb3duIChTU3RhdHVzIDAgU0NvbnRyb2wgMzEwKQ0Kc2F0YV9wcmludF9saW5r
X3N0YXR1czplbmQNCmF0YV9laF9kZXRhY2hfZGV2IDogYXRhX2VoX3RoYXdfcG9ydA0KYXRhX2Vo
X2RldGFjaF9kZXYgOiBhdGFfZWhfcmV2YWxpZGF0ZV9hbmRfYXR0YWNoDQphdGFfcG9ydF9vZmZs
aW5lIDogcG9ydCBpcyBvZmZsaW5lDQphdGExLjAwOiBkaXNhYmxlZA0KYXRhX3BvcnRfb2ZmbGlu
ZSA6IHBvcnQgaXMgb2ZmbGluZQ0KYXRhX2VoX2RldGFjaF9kZXYgOiBzdGFydA0KYXRhX2VoX2Rl
dGFjaF9kZXYgOiBzdGFydA0KYXRhX2VoX2RldGFjaF9kZXYgOiBhdGFfZWhfcHJlcF9yZXN1bWUN
CmF0YV9laF9kZXRhY2hfZGV2IDogYXRhX2VoX3NraXBfcmVjb3ZlcnkNCmF0YV9laF9kZXRhY2hf
ZGV2IDogYXRhX2VoX3JldmFsaWRhdGVfYW5kX2F0dGFjaA0KYXRhX2VoX2RldGFjaF9kZXYgOiBh
dGFfZWhfcmVzdW1lDQphdGFfZWhfZGV0YWNoX2RldiA6IGF0YV9laF9zdXNwZW5kDQphdGFfZG9f
ZWggOiBhdGFfZWhfZmluaXNoDQphdGFfZWhfZmluaXNoIDogc3RhcnQNCmF0YV9ibWRtYV9lcnJv
cl9oYW5kbGVyOiBlbmQNCmF0YTE6IEVIIGNvbXBsZXRlDQphdGExLjAwOiBkZXRhY2hpbmcgKFND
U0kgMDowOjA6MCkNCg==
------=_Part_13225_13880208.1206812847272
Content-Type: text/plain; name=insert_remove.txt
Content-Transfer-Encoding: base64
X-Attachment-Id: f_feeh416y1
Content-Disposition: attachment; filename=insert_remove.txt

W3Jvb3RATkFTMDAxODAwMDEzMTBlIH5dIyBEcml2ZSAxIGluc2VydGVkDQpzaWxfaG9zdF9pbnRy
OjENCnNpbF9ob3N0X2ludHI6NCBhdGFfcG9ydF9mcmVlemUNCnNpbF9mcmVlemUgc3RhcnQNCnNp
bF9mcmVlemUgZW5kDQphdGExIHBvcnQgZnJvemVuDQphdGFfYm1kbWFfZXJyb3JfaGFuZGxlcjog
c3RhcnQNCmF0YV9kb19laCA6IGF0YV9laF9hdXRvcHN5DQphdGFfZWhfYXV0b3BzeSA6IHN0YXJ0
DQphdGFfZG9fZWggOiBhdGFfZWhfcmVwb3J0DQphdGExOiBleGNlcHRpb24gRW1hc2sgMHgxMCBT
QWN0IDB4MCBTRXJyIDB4NTAwMDAgYWN0aW9uIDB4MiBmcm96ZW4NCmF0YV9kb19laCA6IGF0YV9l
aF9yZWNvdmVyDQphdGFfZWhfZGV0YWNoX2RldiA6IHN0YXJ0DQphdGFfZWhfZGV0YWNoX2RldiA6
IGF0YV9laF9wcmVwX3Jlc3VtZQ0KYXRhX2VoX2RldGFjaF9kZXYgOiBhdGFfZWhfc2tpcF9yZWNv
dmVyeQ0Kc2lsX2ZyZWV6ZSBzdGFydA0Kc2lsX2ZyZWV6ZSBlbmQNCmF0YTEgcG9ydCBmcm96ZW4N
CmF0YV9laF9kZXRhY2hfZGV2IDogYXRhX2VoX3Jlc2V0DQphdGFfc3RkX3ByZXJlc2V0OiBzdGFy
dA0KYXRhMTogaGFyZCByZXNldHRpbmcgcG9ydA0KYXRhX3BvcnRfb2ZmbGluZSA6IHBvcnQgaXMg
b2ZmbGluZQ0Kc2F0YV9wcmludF9saW5rX3N0YXR1czpzdGFydA0KYXRhMTogU0FUQSBsaW5rIGRv
d24gKFNTdGF0dXMgMCBTQ29udHJvbCAzMTApDQpzYXRhX3ByaW50X2xpbmtfc3RhdHVzOmVuZA0K
YXRhX2VoX2RldGFjaF9kZXYgOiBhdGFfZWhfdGhhd19wb3J0DQphdGFfZWhfZGV0YWNoX2RldiA6
IGF0YV9laF9yZXZhbGlkYXRlX2FuZF9hdHRhY2gNCmF0YV9laF9kZXRhY2hfZGV2IDogYXRhX2Vo
X3Jlc3VtZQ0KYXRhX2VoX2RldGFjaF9kZXYgOiBhdGFfZWhfc3VzcGVuZA0KYXRhX2RvX2VoIDog
YXRhX2VoX2ZpbmlzaA0KYXRhX2VoX2ZpbmlzaCA6IHN0YXJ0DQphdGFfYm1kbWFfZXJyb3JfaGFu
ZGxlcjogZW5kDQphdGExOiBFSCBjb21wbGV0ZQ0K
------=_Part_13225_13880208.1206812847272--
