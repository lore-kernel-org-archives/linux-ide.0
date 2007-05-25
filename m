From: "Andrew Paprocki" <andrew@ishiboo.com>
Subject: Re: JMicron JMB363 issue fixed / ICH8 RAID volume trace
Date: Thu, 24 May 2007 21:27:25 -0400
Message-ID: <76366b180705241827u2228101eyf8c8b7aa62c594df@mail.gmail.com>
References: <76366b180705231843i19f88582xaf22ba0d58313feb@mail.gmail.com>
	 <46555F7C.4000804@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_Part_120457_15418233.1180056445542"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.180]:36873 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750915AbXEYB10 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 24 May 2007 21:27:26 -0400
Received: by wa-out-1112.google.com with SMTP id j4so261793wah
        for <linux-ide@vger.kernel.org>; Thu, 24 May 2007 18:27:25 -0700 (PDT)
In-Reply-To: <46555F7C.4000804@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: "ethanhsiao@jmicron.com" <ethanhsiao@jmicron.com>, linux-ide@vger.kernel.org

------=_Part_120457_15418233.1180056445542
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Tejun, fdisk -l output is attached

Basically, in the ICH8 BIOS:
/dev/sda + sdb = 2 500GB drives in RAID1 configuration
/dev/sdc + sdd + sde + sdf = 4 320GB drives in RAID5 configuration

/dev/sdg is a 320GB boot drive connected to the JMB363 chipset

Is there some kind of problem when probing these partitions because
they are fake software RAID through the ICH8? The messages only spew
at boot time.

Thanks, -Andrew

On 5/24/07, Tejun Heo <htejun@gmail.com> wrote:
> Andrew Paprocki wrote:
> > Ethan, I believe my 2.6.22-rc2 kernel *is* working with respect to the
> > libata problem. By removing CONFIG_IDE, the system now works fine. The
> > reason why I thought that libata was still having a problem was
> > because the system would hang after agpgart printed:
> > "agpgart: detected an Intel 965G chipset."
> >
> > I *thought* the system was once again waiting for the root drive to
> > become available, but it turns out it was actually hung. I found
> > another user with a Gigabyte board with the same issue. I also have
> > 4GB ram.. http://lists.opensuse.org/opensuse-amd64/2007-04/msg00001.html
> >
> > I added "mem=4096M" to the boot line and now everything is working
> > properly. The IDE subsystem is off and libata is handling everything.
> > I'll post on the kernel mailing list to see if this is a known issue
> > w/ agpgart or amd64+4gb.
> >
> > I do see some trace print out complaining about reads past the end of
> > the device.. Does anyone have an idea if these are harmful? They are
> > coming from my ICH8 RAID volumes:
> >
> > sda: sda1
> > sda: p1 exceeds device capacity
> > sdb: unknown partition table
> > sdc: sdc1
> > sdc: p1 exceeds device capacity
> > sdf1
> > sdf: p1 exceeds device capacity
> > ...
> > attempt to access beyond end of device
> > sda: rw=0, want=1953533832, limit=976773168
> > Buffer I/O error on device sda1, logical block 244191472
> > (repeats about 25 times)
> > attempt to access beyond end of device
> > sdf: rw=0, want=1875410824, limit=625142448
> > (repeats about 25 times)
> > sdc: rw=0, want=1875410824, limit=625142448
> > attempt to access beyond end of device
> > (repeats about 25 times)
>
> What does 'fdisk -l' say?
>
> --
> tejun
> -
> To unsubscribe from this list: send the line "unsubscribe linux-ide" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
>

------=_Part_120457_15418233.1180056445542
Content-Type: text/plain; name=fdisk.052307.txt; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: base64
X-Attachment-Id: f_f23yy1dy
Content-Disposition: attachment; filename="fdisk.052307.txt"

RGlzayAvZGV2L3NkYiBkb2Vzbid0IGNvbnRhaW4gYSB2YWxpZCBwYXJ0aXRpb24gdGFibGUKRGlz
ayAvZGV2L3NkZCBkb2Vzbid0IGNvbnRhaW4gYSB2YWxpZCBwYXJ0aXRpb24gdGFibGUKRGlzayAv
ZGV2L3NkZSBkb2Vzbid0IGNvbnRhaW4gYSB2YWxpZCBwYXJ0aXRpb24gdGFibGUKCkRpc2sgL2Rl
di9zZGE6IDUwMC4xIEdCLCA1MDAxMDc4NjIwMTYgYnl0ZXMKMjU1IGhlYWRzLCA2MyBzZWN0b3Jz
L3RyYWNrLCA2MDgwMSBjeWxpbmRlcnMKVW5pdHMgPSBjeWxpbmRlcnMgb2YgMTYwNjUgKiA1MTIg
PSA4MjI1MjgwIGJ5dGVzCgogICBEZXZpY2UgQm9vdCAgICAgIFN0YXJ0ICAgICAgICAgRW5kICAg
ICAgQmxvY2tzICAgSWQgIFN5c3RlbQovZGV2L3NkYTEgICAqICAgICAgICAgICAxICAgICAgMTIx
NjAyICAgOTc2NzY1OTUyICAgIDcgIEhQRlMvTlRGUwoKRGlzayAvZGV2L3NkYjogNTAwLjEgR0Is
IDUwMDEwNzg2MjAxNiBieXRlcwoyNTUgaGVhZHMsIDYzIHNlY3RvcnMvdHJhY2ssIDYwODAxIGN5
bGluZGVycwpVbml0cyA9IGN5bGluZGVycyBvZiAxNjA2NSAqIDUxMiA9IDgyMjUyODAgYnl0ZXMK
CgpEaXNrIC9kZXYvc2RjOiAzMjAuMCBHQiwgMzIwMDcyOTMzMzc2IGJ5dGVzCjI1NSBoZWFkcywg
NjMgc2VjdG9ycy90cmFjaywgMzg5MTMgY3lsaW5kZXJzClVuaXRzID0gY3lsaW5kZXJzIG9mIDE2
MDY1ICogNTEyID0gODIyNTI4MCBieXRlcwoKICAgRGV2aWNlIEJvb3QgICAgICBTdGFydCAgICAg
ICAgIEVuZCAgICAgIEJsb2NrcyAgIElkICBTeXN0ZW0KL2Rldi9zZGMxICAgICAgICAgICAgICAg
MSAgICAgIDExNjczOSAgIDkzNzcwNDQ0OCAgICA3ICBIUEZTL05URlMKCkRpc2sgL2Rldi9zZGQ6
IDMyMC4wIEdCLCAzMjAwNzI5MzMzNzYgYnl0ZXMKMjU1IGhlYWRzLCA2MyBzZWN0b3JzL3RyYWNr
LCAzODkxMyBjeWxpbmRlcnMKVW5pdHMgPSBjeWxpbmRlcnMgb2YgMTYwNjUgKiA1MTIgPSA4MjI1
MjgwIGJ5dGVzCgoKRGlzayAvZGV2L3NkZTogMzIwLjAgR0IsIDMyMDA3MjkzMzM3NiBieXRlcwoy
NTUgaGVhZHMsIDYzIHNlY3RvcnMvdHJhY2ssIDM4OTEzIGN5bGluZGVycwpVbml0cyA9IGN5bGlu
ZGVycyBvZiAxNjA2NSAqIDUxMiA9IDgyMjUyODAgYnl0ZXMKCgpEaXNrIC9kZXYvc2RmOiAzMjAu
MCBHQiwgMzIwMDcyOTMzMzc2IGJ5dGVzCjI1NSBoZWFkcywgNjMgc2VjdG9ycy90cmFjaywgMzg5
MTMgY3lsaW5kZXJzClVuaXRzID0gY3lsaW5kZXJzIG9mIDE2MDY1ICogNTEyID0gODIyNTI4MCBi
eXRlcwoKICAgRGV2aWNlIEJvb3QgICAgICBTdGFydCAgICAgICAgIEVuZCAgICAgIEJsb2NrcyAg
IElkICBTeXN0ZW0KL2Rldi9zZGYxICAgICAgICAgICAgICAgMSAgICAgIDExNjczOSAgIDkzNzcw
NDQ0OCAgICA3ICBIUEZTL05URlMKCkRpc2sgL2Rldi9zZGc6IDMyMC4wIEdCLCAzMjAwNzI5MzMz
NzYgYnl0ZXMKMjU1IGhlYWRzLCA2MyBzZWN0b3JzL3RyYWNrLCAzODkxMyBjeWxpbmRlcnMKVW5p
dHMgPSBjeWxpbmRlcnMgb2YgMTYwNjUgKiA1MTIgPSA4MjI1MjgwIGJ5dGVzCgogICBEZXZpY2Ug
Qm9vdCAgICAgIFN0YXJ0ICAgICAgICAgRW5kICAgICAgQmxvY2tzICAgSWQgIFN5c3RlbQovZGV2
L3NkZzEgICAgICAgICAgICAgICAxICAgICAgIDMyNjgwICAgMjYyNTAwMzUyICAgIDcgIEhQRlMv
TlRGUwovZGV2L3NkZzIgICAgICAgICAgIDMyNjgwICAgICAgIDMyNzEzICAgICAgMjYyMTQ0ICAg
ODIgIExpbnV4IHN3YXAgLyBTb2xhcmlzCi9kZXYvc2RnMyAgICogICAgICAgMzI3MTMgICAgICAg
Mzg5MTQgICAgNDk4MDYzMzYgICA4MyAgTGludXgK
------=_Part_120457_15418233.1180056445542--
