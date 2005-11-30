From: Tejun Heo <htejun@gmail.com>
Subject: Re: totally random "VFS: Cannot open root device"
Date: Wed, 30 Nov 2005 13:35:37 +0900
Message-ID: <438D2C19.3030008@gmail.com>
References: <438B6E05.8070009@eq.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-2; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1750911AbVK3Efp@vger.kernel.org>
In-Reply-To: <438B6E05.8070009@eq.cz>
Sender: linux-kernel-owner@vger.kernel.org
To: "0602@eq.cz" <0602@eq.cz>
Cc: linux-kernel@vger.kernel.org, Linux-ide <linux-ide@vger.kernel.org>
List-Id: linux-ide@vger.kernel.org

0602@eq.cz wrote:
> Hi!
> 
> (Please CC me your answers as I am not subscribed.)
> 
> I have a problem with 2.6.14.3 kernel (but this probably isn't too 
> version-specific). I have a kernel which succesfully boots on totally 
> random basis (cca 70% is success). My root partition resides on a SATA 
> disc connected to a controller on Intel 6300ESB ICH southbridge (mb 
> Intel se7320vp2). There is a reiserfs 3 filesystem on my root partition. 
> Without any changes to configuration (os or bios or whatever) I 
> sometimes get:
> 
> VFS: Cannot open root device "801" or unknown block(8,1)
> 
> Could this be some timeout issue, or indication of crappy hw? I've tried 
> this about 10 times (immediately ctrl+alt+del on successfull boot or 
> reset button on aforementioned panic) and I saw no regularities in this 
> misbehaviour.
> 
> I sincerely appreciate any advice anyone can give.
> 

[CC'ing linux-ide]

Hello, 0602.  :-)

Can you please post dmesg of a successful booting?  That will tell us 
which SATA controller/disks you are using.  Also, the boot log of a 
failed boot will be very helpful - the best way to get this is via 
serial console.  If you don't have access to serial console, taking note 
   / picture of the part where SATA detection fails will do too.

Also, when the machine boots successfully, does it work without 
generating disk related kernel logs?  Just perform any IO-heavy 
operations - cp'ing directories which contain large files, 
tar/untarring... - and see if the kernel complains about anyting.

-- 
tejun
