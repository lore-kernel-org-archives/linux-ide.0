From: Petr Vandrovec <vandrove@vc.cvut.cz>
Subject: Re: errors on shutdown with PMP
Date: Tue, 31 Jul 2007 02:16:40 -0700
Message-ID: <46AEFDF8.9010904@vc.cvut.cz>
References: <200707272153.l6RLrE5r007622@outgoing-alum.mit.edu> <46AAF12F.9020301@gmail.com> <200707310341.l6V3ex5r011162@outgoing-alum.mit.edu> <46AEBB71.9040003@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mailgw.cvut.cz ([147.32.3.235]:50471 "EHLO mailgw.cvut.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754420AbXGaJ4G (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 31 Jul 2007 05:56:06 -0400
In-Reply-To: <46AEBB71.9040003@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Marc Bejarano <beej@alum.mit.edu>, linux-ide@vger.kernel.org

Tejun Heo wrote:
> Marc Bejarano wrote:
>> At 03:33 7/28/2007, Tejun Heo wrote:
>>> Device times out write.
>> odd that it would be able to be part of an lv's filesystem that had
>> hundreds of gigabytes recently written to it and then choke on flushing
>> during shutdown.
>>
>>> And then never comes back.
>> asleep at the wheel ;)
>>
>>> Please post the result of 'smartctl -a /dev/sdX' where sdX is the device
>>> which went offline.
>> i suppose i should have seen that coming.  here you go:
>> ===
>> [root@dell ~]# /usr/local/sbin/smartctl -a /dev/sdc
>> smartctl version 5.37 [x86_64-unknown-linux-gnu] Copyright (C) 2002-6
>> Bruce Allen
>> Home page is http://smartmontools.sourceforge.net/
>>
>> === START OF INFORMATION SECTION ===
>> Model Family:     Seagate Barracuda 7200.10 family
>> Device Model:     ST3750640AS
> [--snip--]
>> ID# ATTRIBUTE_NAME          FLAG     VALUE WORST THRESH TYPE     
>> UPDATED  WHEN_FAILED RAW_VALUE
>>   1 Raw_Read_Error_Rate     0x000f   090   079   006    Pre-fail  Always
>>      -       66902364
>>   5 Reallocated_Sector_Ct   0x0033   100   100   036    Pre-fail  Always
>>      -       31
>>   7 Seek_Error_Rate         0x000f   081   060   030    Pre-fail  Always
>>      -       146651228
>> 195 Hardware_ECC_Recovered  0x001a   056   049   000    Old_age   Always
>>      -       102514302
>> 198 Offline_Uncorrectable   0x0010   099   099   000    Old_age  
>> Offline      -       40
> 
> Counters don't look too friendly.  Do you happen to have another drive
> of the same model?  If so, can you post smartctl -a of the drive?

Offline_Uncorrectable looks bad, as well as Reallocated_Sector_Ct... 
For Raw_Read_Error_Rate/Seek_Error_Rate/Hardware_ECC_Recovered it is how 
Seagates work:

gwy:~# for a in /dev/sd[a-f]; do smartctl -a $a; done | grep 
'\(Raw_Read\|Seek_Error\|Hardware_ECC\|Offline_Uncorr\|Reallocated\|^Device 
M\|^Firmware\)'
Device Model:     Hitachi HDT725032VLA380
Firmware Version: V54OA52A
   1 Raw_Read_Error_Rate     0x000b   100   100   016    Pre-fail 
Always       -       0
   5 Reallocated_Sector_Ct   0x0033   100   100   005    Pre-fail 
Always       -       0
   7 Seek_Error_Rate         0x000b   100   100   067    Pre-fail 
Always       -       0
196 Reallocated_Event_Count 0x0032   100   100   000    Old_age   Always 
       -       0
198 Offline_Uncorrectable   0x0008   100   100   000    Old_age 
Offline      -       0
Device Model:     Hitachi HDS721010KLA330
Firmware Version: GKAOA70F
   1 Raw_Read_Error_Rate     0x000b   100   100   016    Pre-fail 
Always       -       0
   5 Reallocated_Sector_Ct   0x0033   100   100   005    Pre-fail 
Always       -       0
   7 Seek_Error_Rate         0x000b   100   100   067    Pre-fail 
Always       -       0
196 Reallocated_Event_Count 0x0032   100   100   000    Old_age   Always 
       -       0
198 Offline_Uncorrectable   0x0008   100   100   000    Old_age 
Offline      -       0
Device Model:     ST3750640AS
Firmware Version: 3.AAE
   1 Raw_Read_Error_Rate     0x000f   110   087   006    Pre-fail 
Always       -       201790283
   5 Reallocated_Sector_Ct   0x0033   100   100   036    Pre-fail 
Always       -       0
   7 Seek_Error_Rate         0x000f   076   060   030    Pre-fail 
Always       -       43520234
195 Hardware_ECC_Recovered  0x001a   059   050   000    Old_age   Always 
       -       40212951
198 Offline_Uncorrectable   0x0010   100   100   000    Old_age 
Offline      -       0
Device Model:     Hitachi HDS721010KLA330
Firmware Version: GKAOA70F
   1 Raw_Read_Error_Rate     0x000b   100   100   016    Pre-fail 
Always       -       0
   5 Reallocated_Sector_Ct   0x0033   100   100   005    Pre-fail 
Always       -       0
   7 Seek_Error_Rate         0x000b   100   100   067    Pre-fail 
Always       -       0
196 Reallocated_Event_Count 0x0032   100   100   000    Old_age   Always 
       -       0
198 Offline_Uncorrectable   0x0008   100   100   000    Old_age 
Offline      -       0
Device Model:     ST3750640AS
Firmware Version: 3.AAD
   1 Raw_Read_Error_Rate     0x000f   114   083   006    Pre-fail 
Always       -       121388046
   5 Reallocated_Sector_Ct   0x0033   100   100   036    Pre-fail 
Always       -       0
   7 Seek_Error_Rate         0x000f   078   065   030    Pre-fail 
Always       -       78605591
195 Hardware_ECC_Recovered  0x001a   066   050   000    Old_age   Always 
       -       194670617
198 Offline_Uncorrectable   0x0010   100   100   000    Old_age 
Offline      -       0
Device Model:     Sans Digital V.36.B0D
Firmware Version: V.36.B0D


BTW, sdb-sde are behind PMP, no problems on shutdown.  Funniest is that 
all these counters are 32bit, so during day you see like your disk is 
estimated to die in 5 days, then suddenly that 32bit counter overflows, 
and your disk is again healthy as possible.  I did not measure what 
these counters actually count on these 750GB drives, but on 100GB 
notebook Seagate drive every sector read counts as 3-5 ECC errors, and 
every Smart data interrogation as 1...
								Petr


