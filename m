From: Tejun Heo <htejun@gmail.com>
Subject: Re: [2.6.19-rc2] SATA boot problems
Date: Fri, 20 Oct 2006 17:56:04 +0900
Message-ID: <45388F24.6000407@gmail.com>
References: <4537697C.7080500@tweerlei.de> <4537DEFC.5050404@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S932213AbWJTI4O@vger.kernel.org>
In-Reply-To: <4537DEFC.5050404@rtr.ca>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Lord <lkml@rtr.ca>
Cc: Robert Wruck <wruck@tweerlei.de>, IDE/ATA development list <linux-ide@vger.kernel.org>, linux-kernel@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

Mark Lord wrote:
> Hi.  I'm copying your posting for the linux-ide mailing list,
> where the libata designers hang out.
> 
> Robert Wruck wrote:
>> Hi,
>>
>> I'm having problems booting from a SATA disk with 2.6.19-rc2.
>> Grub loads fine, but when the kernel boots, it *sometimes* ends up with
>> VFS: Cannot open root device "sda5" or unknown-block(0,0)
>>
>> The strange thing is that this happens only in 2/3 of the boot attempts.
>> If I reset the machine, the next attempt is likely to succeed.
>> I first noted this when switching from 2.6.17 (2.6.17.11, IIRC) to
>> 2.6.18 and it persists in 2.6.19-rc2 (Windows does not encounter similar
>> problems on the same machine).
>>
>> I attached a diff of a successful and an unsuccessful netconsole log
>> below. It seems that the drive is sometimes simply not detected...
>> I'm not using an initrd and changing the kernel command line from
>> root=/dev/sda5 to root=0x0805 did not help.
>>
>> The controller is:
>> 00:1f.2 IDE interface: Intel Corporation 82801FB/FW (ICH6/ICH6W) SATA
>> Controller (rev 03)
>>
>> Any ideas? Please CC me, as I'm not subscribed.
>> Robert

Can you give a shot at the latest -mm (2.6.19-rc2-mm2)?  It contains 
device-detection-via-polling which is supposed to fix problems similar 
to yours.

-- 
tejun
