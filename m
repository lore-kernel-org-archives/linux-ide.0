From: =?UTF-8?B?SMOla29uIEzDuHZkYWw=?= <hlovdal@gmail.com>
Subject: Re: "raid5:md0: read error not correctable (sector 795463080 on
	sdf1)" error on controller with SIL 3114
Date: Wed, 17 Feb 2010 03:42:45 +0100
Message-ID: <a01a16b51002161842h3c2da6dbnbeb52ff1b6802bf@mail.gmail.com>
References: <a01a16b51002080311i420f6429ld3545c44c04603eb@mail.gmail.com>
	 <4B70EEFD.1040603@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-fx0-f215.google.com ([209.85.220.215]:61335 "EHLO
	mail-fx0-f215.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933508Ab0BQCmt convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 16 Feb 2010 21:42:49 -0500
Received: by fxm7 with SMTP id 7so8054420fxm.28
        for <linux-ide@vger.kernel.org>; Tue, 16 Feb 2010 18:42:47 -0800 (PST)
In-Reply-To: <4B70EEFD.1040603@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Robert Hancock <hancockrwd@gmail.com>
Cc: linux-ide@vger.kernel.org

On 9 February 2010 06:13, Robert Hancock <hancockrwd@gmail.com> wrote:
> On 02/08/2010 05:11 AM, H=C3=A5kon L=C3=B8vdal wrote:
>> ---BEGIN log-4---
>> Feb =C2=A06 07:09:57 localhost kernel: ata8.00: exception Emask 0x0 =
SAct
>> 0x0 SErr 0x0 action 0x0
>> Feb =C2=A06 07:09:57 localhost kernel: ata8.00: BMDMA2 stat 0x6c0009
>> Feb =C2=A06 07:09:57 localhost kernel: ata8.00: cmd
>> 25/00:80:cf:cd:69/00:00:2f:00:00/e0 tag 0 dma 65536 in
>> Feb =C2=A06 07:09:57 localhost kernel: =C2=A0 =C2=A0 =C2=A0 =C2=A0 r=
es
>> 51/40:00:e4:cd:69/00:00:2f:00:00/e0 Emask 0x9 (media error)
>> Feb =C2=A06 07:09:57 localhost kernel: ata8.00: status: { DRDY ERR }
>> Feb =C2=A06 07:09:57 localhost kernel: ata8.00: error: { UNC }
>
> That's fairly definitive, uncorrected read error reported by the driv=
e. You
> might want to check its SMART status. Could be a bad drive, or potent=
ially
> other causes like excessive vibration, high temperature, power issues=
=2E.

=46or all of sdb, sdc, sdd, sde, sdf and sdg they all have had a
normalized value of 100 for the whole lifetime of the disk (I have
a cron job to capture output from smartctl nightly for reference
and have now checked those files) for all the critical attributes liste=
d at
http://en.wikipedia.org/wiki/S.M.A.R.T.#ATA_S.M.A.R.T._attributes
  1 Raw_Read_Error_Rate
  5 Reallocated_Sector_Ct
 10 Spin_Retry_Count
184 Unknown_Attribute
188 Unknown_Attribute
196 Reallocated_Event_Count
197 Current_Pending_Sector
198 Offline_Uncorrectable
201 Soft_Read_Error_Rate
except for Soft_Read_Error_Rate which switches between either 100 or 25=
3.

The disks are now placed in a Image Shapetek EYE-981SC tower[1] with go=
od space,
and the disks are placed in 5.25" bays with rubber hard disk stabilizer=
s[1] to
reduce vibration. There is therefore good airflow around all the
disks, and I keep
one side of the tower case open, so temperature should not be a
problem (any longer).

In the previous case space could be more tight. I see that last summer
hde and hdf had temperatures of around 45-55=C2=B0C in June/July which =
does not
sound too good[3]. They are still part of the raid, whereas hdc which h=
as
an excellent temperature profile of 35-45=C2=B0C and hdd (28-38) are th=
e two
disks being currently kicked out of the rad.

There might be some issues with the PSU[4] (I am waiting for a new one)=
=2E I doubt
there are any problem with line electricity because the quality is
generally quite
good here in Norway and besides the machine is behind an UPS.

smartctl -l selftest /dev/sde gives
    Num  Test_Description    Status                  Remaining
LifeTime(hours)  LBA_of_first_error
    # 1  Extended offline    Completed: read failure       90%
795         1465145815
    # 2  Conveyance offline  Completed: read failure       90%
794         1465145815
    # 3  Offline             Completed: read failure       00%
790         1465145815
    # 4  Short offline       Completed: read failure       20%
787         1465145815
None of the other disks report any selftest failures.

So sde and sdf show some sign of trouble (temperature, selftest and ata=
8.00
exception above), but they are not kicked out of the raid. On the other=
 hand
sdc and sdd are both kicked out and I cannot see any obvious signs of h=
ardware
trouble here. Any suggestions?


BR H=C3=A5kon L=C3=B8vdal

[1]
http://translate.google.com/translate?js=3Dy&prev=3D_t&hl=3Den&ie=3DUTF=
-8&layout=3D1&eotf=3D1&u=3Dhttp%3A%2F%2Fwww.hardware.no%2Fartikler%2Fi_=
s_981_servertower%2F46558%2Futskrift&sl=3Dno&tl=3Den

[2]
http://www.scythe-eu.com/en/products/pc-accessory/hard-disk-stabilizer-=
2.html

[3]
http://en.wikibooks.org/wiki/Minimizing_hard_disk_drive_failure_and_dat=
a_loss#Temperature_control

[4]
350W, Point of view, VP-3504
