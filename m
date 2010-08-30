From: Siddhartha Jain <siddhartha@siddharthajain.net>
Subject: Re: [PATCH] SATA / AHCI: Do not play with the link PM during suspend
 to RAM
Date: Mon, 30 Aug 2010 08:25:10 -0700
Message-ID: <AANLkTimEQEAF7WfCmmSfS_Ryq7HEfqemAnh9BvdKRhqL@mail.gmail.com>
References: <1283027290.2721.37.camel@myfedorahat>
	<4C7BAA42.2050809@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-pz0-f46.google.com ([209.85.210.46]:38707 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754694Ab0H3PZL convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 30 Aug 2010 11:25:11 -0400
Received: by pzk9 with SMTP id 9so2103145pzk.19
        for <linux-ide@vger.kernel.org>; Mon, 30 Aug 2010 08:25:11 -0700 (PDT)
In-Reply-To: <4C7BAA42.2050809@kernel.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Hi Tejun,

Will get more debugging info by setting up netconsole. Meanwhile,
syslog did glean some important info, I think. Looks like, for some
reason, after resume, device mapping for the hdd changes from sda to
sdc. Please see logs below. For ease of troubleshooting, I
re-installed the box with stock Fedora 13 x64 with no modifications
except that dmcrypt is turned on for root and swap (so using Nouveau
display drivers instead of Nvidia).

Aug 29 19:13:45 192.168.1.199 kernel: PM: Syncing filesystems ... done.
Aug 29 19:13:45 192.168.1.199 kernel: PM: Preparing system for mem slee=
p
Aug 29 19:18:57 192.168.1.199 kernel: scsi 0:0:0:0: Direct-Access
ATA      FUJITSU MJA2250B 0081 PQ: 0 ANSI: 5
Aug 29 19:18:57 192.168.1.199 kernel: sd 0:0:0:0: Attached scsi
generic sg0 type 0
Aug 29 19:18:57 192.168.1.199 kernel: ata2.00: detaching (SCSI 1:0:0:0)
Aug 29 19:18:57 192.168.1.199 kernel: sd 0:0:0:0: [sdc] 488397168
512-byte logical blocks: (250 GB/232 GiB)
Aug 29 19:18:57 192.168.1.199 kernel: sd 0:0:0:0: [sdc] Write Protect i=
s off
Aug 29 19:18:57 192.168.1.199 kernel: sd 0:0:0:0: [sdc] Mode Sense: 00 =
3a 00 00
Aug 29 19:18:57 192.168.1.199 kernel: sd 0:0:0:0: [sdc] Write cache:
enabled, read cache: enabled, doesn't support DPO or FUA
Aug 29 19:18:57 192.168.1.199 kernel: sdc:
Aug 29 19:18:57 192.168.1.199 kernel: scsi 1:0:0:0: CD-ROM
HL-DT-ST DVDRW  GS23N     SB03 PQ: 0 ANSI: 5
Aug 29 19:18:57 192.168.1.199 kernel: sr0: scsi3-mmc drive: 24x/24x
writer cd/rw xa/form2 cdda caddy
Aug 29 19:18:57 192.168.1.199 kernel: sr 1:0:0:0: Attached scsi CD-ROM =
sr0
Aug 29 19:18:57 192.168.1.199 kernel: sr 1:0:0:0: Attached scsi
generic sg1 type 5
Aug 29 19:18:58 192.168.1.199 kernel: sdc1 sdc2 sdc3
Aug 29 19:18:58 192.168.1.199 kernel: sd 0:0:0:0: [sdc] Attached SCSI d=
isk
Aug 29 19:20:20 192.168.1.199 ntpd[1466]: 0.0.0.0 c61c 0c clock_step -0=
=2E389692 s
Aug 29 19:20:20 192.168.1.199 ntpd[1466]: 0.0.0.0 c614 04 freq_mode
Aug 29 19:20:21 192.168.1.199 ntpd[1466]: 0.0.0.0 c618 08 no_sys_peer
Aug 29 19:22:29 192.168.1.199 sshd[2425]: WARNING: no suitable primes
in /etc/ssh/primes
Aug 29 19:22:29 192.168.1.199 rsyslogd: /var/log/secure
Aug 29 19:22:37 192.168.1.199 auditd[1734]: Record was not written to
disk (Read-only file system)
Aug 29 19:22:37 192.168.1.199 auditd[1734]: write: Audit daemon
detected an error writing an event to disk (Connection refused)
Aug 29 19:22:37 192.168.1.199 sshd[2425]: Failed password for sjain
from 192.168.1.100 port 49902 ssh2
Aug 29 19:22:37 192.168.1.199 auditd[2428]: Audit daemon failed to exec=
 (null)
Aug 29 19:22:37 192.168.1.199 auditd[2428]: The audit daemon is exiting=
=2E
Aug 29 19:22:37 192.168.1.199 auditd[1734]: Record was not written to
disk (Read-only file system)
Aug 29 19:22:37 192.168.1.199 auditd[1734]: write: Audit daemon
detected an error writing an event to disk (Read-only file system)
Aug 29 19:22:37 192.168.1.199 auditd[2429]: Audit daemon failed to exec=
 (null)
Aug 29 19:22:37 192.168.1.199 auditd[2429]: The audit daemon is exiting=
=2E
Aug 29 19:22:37 192.168.1.199 kernel: type=3D1305
audit(1283134957.511:19078): audit_pid=3D0 old=3D1734 auid=3D4294967295
ses=3D4294967295 res=3D1
Aug 29 19:22:37 192.168.1.199 kernel: type=3D1305
audit(1283134957.511:19079): audit_pid=3D0 old=3D0 auid=3D4294967295
ses=3D4294967295 res=3D1
Aug 29 19:22:54 192.168.1.199 kernel: EXT3-fs error (device dm-0):
ext3_find_entry: reading directory #10445218 offset 0
Aug 29 19:22:54 192.168.1.199 sshd[2426]: Connection closed by 192.168.=
1.100
Aug 29 19:23:17 192.168.1.199 auditd[2428]: Error setting audit daemon
pid (Resource temporarily unavailable)
Aug 29 19:23:18 192.168.1.199 auditd[2429]: Error setting audit daemon
pid (Resource temporarily unavailable)
Aug 29 19:34:26 192.168.1.199 kernel: CE: hpet increasing min_delta_ns
to 15000 nsec
Aug 29 19:35:46 192.168.1.199 ntpd[1466]: 0.0.0.0 c612 02 freq_set
kernel -65.666 PPM
Aug 29 19:35:46 192.168.1.199 ntpd[1466]: 0.0.0.0 c615 05 clock_sync
Aug 29 19:38:26 192.168.1.199 kernel: EXT3-fs error (device dm-0):
ext3_find_entry: reading directory #1803721 offset 0

Odd?

Thanks,

- Siddhartha



On Mon, Aug 30, 2010 at 5:55 AM, Tejun Heo <tj@kernel.org> wrote:
> On 08/28/2010 10:28 PM, Siddhartha Jain wrote:
>> I am going to try pointing rsyslog at a remote syslog server to see =
if I
>> can capture what happens at resume-time but any other pointers to
>> debug/troubleshoot this issue will be helpful.
>
> Setting up netconsole (see Documentation/networking/netconsole.txt in
> the kernel source tree) would be better.
>
> Thanks.
>
> --
> tejun
> --
> To unsubscribe from this list: send the line "unsubscribe linux-ide" =
in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>



--=20
- Siddhartha
=A0 WV6U
