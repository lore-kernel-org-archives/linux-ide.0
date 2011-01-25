From: Robert Hancock <hancockrwd@gmail.com>
Subject: Re: Seagate hard disk firmware issue
Date: Mon, 24 Jan 2011 19:21:51 -0600
Message-ID: <4D3E25AF.1080102@gmail.com>
References: <AANLkTinvjz0n6bq3Q218w2bs6tjVu5-p8WcpH7kzyMS_@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-iw0-f174.google.com ([209.85.214.174]:40900 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752166Ab1AYBVy (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 24 Jan 2011 20:21:54 -0500
Received: by iwn9 with SMTP id 9so4596906iwn.19
        for <linux-ide@vger.kernel.org>; Mon, 24 Jan 2011 17:21:53 -0800 (PST)
In-Reply-To: <AANLkTinvjz0n6bq3Q218w2bs6tjVu5-p8WcpH7kzyMS_@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: BU66ER BAD6ER <debu66er@gmail.com>
Cc: linux-ide@vger.kernel.org

On 01/23/2011 05:05 AM, BU66ER BAD6ER wrote:
> Hi,
>
> Four weeks ago I bought a new 2TB Seagate Barracuda internal SATA
> drive. That drive has two 667GB ext4 partions (667GB unused) and it is
> used for storage. My main system (Debian Sid 64-bit and KDE) resides
> on a 40GB SSD, also using ext4.
>
> Two weeks ago I noticed a severe performance drop, where any file
> manager couldn't view directories on the 2TB disk without a one or two
> minute penalty. After that I have had three hard freezes of that disk
> and the entire system. Before the freeze there is very much hd
> activity and finally I need to turn the power off. I have now also
> made a backup of /dev/sdb1 should it be fatally serious.
>
> I was recommended by someone at the #debian irc to make changes to the
> spindown_time but that only helped for a few days. Yesterday, the 3rd
> freeze came and the system wouldn't even recognize the disk after
> reboot; just 'clicking' waiting for a response. I showed the kern.log
> to someone at the same channel who concluded that this should be a
> firmware issue.
>
> Here is the latest kern.log which may identify the issue: I hope it
> contains the relevant details. But first the output of smartctl -a
> /dev/sdb.
>
> I have now set the hdparm spindown_time to 0, disabling disk sleep
> which seems to have been the culprit as judged on messages in the
> Dolphin file manager etc.
>
> Thanks for any help!
>
>
>> # smartctl -a /dev/sdb
>> smartctl 5.40 2010-07-12 r3124 [x86_64-unknown-linux-gnu] (local build)
>> Copyright (C) 2002-10 by Bruce Allen, http://smartmontools.sourceforge.net
>>
>> === START OF INFORMATION SECTION ===
>> Model Family:     Seagate Barracuda LP
>> Device Model:     ST32000542AS
>> Serial Number:    5XW20H7P
>> Firmware Version: CC34
>> User Capacity:    2,000,398,934,016 bytes
>> Device is:        In smartctl database [for details use: -P show]
>> ATA Version is:   8
>> ATA Standard is:  ATA-8-ACS revision 4
>> Local Time is:    Sun Jan 23 11:50:56 2011 CET
>> SMART support is: Available - device has SMART capability.
>> SMART support is: Enabled
>>
>> === START OF READ SMART DATA SECTION ===
>> SMART overall-health self-assessment test result: PASSED
>>
>> General SMART Values:
>> Offline data collection status:  (0x00) Offline data collection activity
>>                                          was never started.
>>                                          Auto Offline Data Collection: Disabled.
>> Self-test execution status:      (   0) The previous self-test routine completed
>>                                          without error or no self-test has ever
>>                                          been run.
>> Total time to complete Offline
>> data collection:                 ( 633) seconds.
>> Offline data collection
>> capabilities:                    (0x73) SMART execute Offline immediate.
>>                                          Auto Offline data collection on/off support.
>>                                          Suspend Offline collection upon new
>>                                          command.
>>                                          No Offline surface scan supported.
>>                                          Self-test supported.
>>                                          Conveyance Self-test supported.
>>                                          Selective Self-test supported.
>> SMART capabilities:            (0x0003) Saves SMART data before entering
>>                                          power-saving mode.
>>                                          Supports SMART auto save timer.
>> Error logging capability:        (0x01) Error logging supported.
>>                                          General Purpose Logging supported.
>> Short self-test routine
>> recommended polling time:        (   1) minutes.
>> Extended self-test routine
>> recommended polling time:        ( 255) minutes.
>> Conveyance self-test routine
>> recommended polling time:        (   2) minutes.
>> SCT capabilities:              (0x103f) SCT Status supported.
>>                                          SCT Error Recovery Control supported.
>>                                          SCT Feature Control supported.
>>                                          SCT Data Table supported.
>>
>> SMART Attributes Data Structure revision number: 10
>> Vendor Specific SMART Attributes with Thresholds:
>> ID# ATTRIBUTE_NAME          FLAG     VALUE WORST THRESH TYPE      UPDATED  WHEN_FAILED RAW_VALUE
>>    1 Raw_Read_Error_Rate     0x000f   100   089   006    Pre-fail  Always       -       184733939
>>    3 Spin_Up_Time            0x0003   100   100   000    Pre-fail  Always       -       0
>>    4 Start_Stop_Count        0x0032   099   099   020    Old_age   Always       -       1160
>>    5 Reallocated_Sector_Ct   0x0033   100   100   036    Pre-fail  Always       -       0
>>    7 Seek_Error_Rate         0x000f   100   253   030    Pre-fail  Always       -       296094
>>    9 Power_On_Hours          0x0032   100   100   000    Old_age   Always       -       307
>>   10 Spin_Retry_Count        0x0013   100   100   097    Pre-fail  Always       -       0
>>   12 Power_Cycle_Count       0x0032   099   099   020    Old_age   Always       -       1186
>> 183 Runtime_Bad_Block       0x0032   100   100   000    Old_age   Always       -       0
>> 184 End-to-End_Error        0x0032   100   100   099    Old_age   Always       -       0
>> 187 Reported_Uncorrect      0x0032   001   001   000    Old_age   Always       -       225
>> 188 Command_Timeout         0x0032   100   099   000    Old_age   Always       -       4295032833
>> 189 High_Fly_Writes         0x003a   100   100   000    Old_age   Always       -       0
>> 190 Airflow_Temperature_Cel 0x0022   063   063   045    Old_age   Always       -       37 (Lifetime Min/Max 19/37)
>> 194 Temperature_Celsius     0x0022   037   040   000    Old_age   Always       -       37 (0 16 0 0)
>> 195 Hardware_ECC_Recovered  0x001a   052   033   000    Old_age   Always       -       184733939
>> 197 Current_Pending_Sector  0x0012   100   099   000    Old_age   Always       -       40
>> 198 Offline_Uncorrectable   0x0010   100   099   000    Old_age   Offline      -       40
>> 199 UDMA_CRC_Error_Count    0x003e   200   200   000    Old_age   Always       -       0
>> 240 Head_Flying_Hours       0x0000   100   253   000    Old_age   Offline      -       210019605808507
>> 241 Total_LBAs_Written      0x0000   100   253   000    Old_age   Offline      -       546635184
>> 242 Total_LBAs_Read         0x0000   100   253   000    Old_age   Offline      -       2195715347

The SMART data shows there haven't been many start/stops other than from 
power cycles, so I don't think spindown is related here. The error log 
entries and the Offline_Uncorrectable and Reported_Uncorrect attributes 
would indicate that your drive is having read errors. Think you likely 
need a new drive.
