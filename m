From: Aaron Lu <aaron.lu@intel.com>
Subject: Re: STANDBY IMMEDIATE failed on NVIDIA MCP5x controllers when system
 suspend
Date: Wed, 13 Mar 2013 10:36:41 +0800
Message-ID: <513FE639.90401@intel.com>
References: <513D52BE.7040307@intel.com> <1363032071.4669.9.camel@donpedro.P-2601HN-F1> <513E9444.1090104@intel.com> <1363130462.4669.31.camel@donpedro.P-2601HN-F1> <CADLC3L28BQmwjicnA86zA4Tf42O9MygauNdnK2SanqazwtgpoQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:16176 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755550Ab3CMCfh (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 12 Mar 2013 22:35:37 -0400
In-Reply-To: <CADLC3L28BQmwjicnA86zA4Tf42O9MygauNdnK2SanqazwtgpoQ@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Robert Hancock <hancockrwd@gmail.com>, Kuan Luo <kluo@nvidia.com>, Peer Chen <pchen@nvidia.com>
Cc: donpedro@tdcadsl.dk, bladud@gmail.com, Joe Sapp <nixphoeni+kernel@gmail.com>, Alberto Mattea <support.intranet@libero.it>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, Tejun Heo <tj@kernel.org>, Jeff Garzik <jgarzik@pobox.com>

On 03/13/2013 10:10 AM, Robert Hancock wrote:
> On Tue, Mar 12, 2013 at 5:21 PM, Peter Dons Tychsen <donpedro@tdcadsl.dk> wrote:
>> Hello again,
>>
>> On Tue, 2013-03-12 at 10:34 +0800, Aaron Lu wrote:
>>> The device that is responsible for PM operations for the disk is named
>>> something like sd X:0:0:0, where X is the host number, and is normally
>>> attached under the ata port number+1. So sd 2:0:0:0 is attached to ata
>>> port 3(if there are USB disks, things may change). And the ata port
>>> device is reponsible for ata port level PM operations like power off
>>> the
>>> port etc., and its device is named as atax, where x is its port
>>> number.
>>> So you can see from the log, only after sd 4:0:0:0 and sd 2:0:0:0
>>> failed
>>> in their ->suspend function, ata5 and ata3's suspend functions start
>>> to
>>> run, and then sata_nv 0000:00:05.1 starts to run.
>>
>> Yes, but 1 thing completes before disks are suspended:
>>
>> [ 7378.237631] sata_nv 0000:00:05.2: __device_suspend: starts
>> [ 7378.249333] sata_nv 0000:00:05.2: __device_suspend: done
>>
>> And then sd 2:0:0:0 starts to suspend.
>>
>> This might be correct seen from a dependency point of view. But what if
>> the HW designer was a bit lazy (or saved a bit of logic), and performs
>> some sort of shutdown when the first function (0000:00:05.2) is
>> suspended? That would require all disks attached to be dependent on all
>> functions.
> 
> I am not sure that inter-function dependencies are the issue here
> (although given these NVIDIA controllers, anything is possible).
> Looking at the dmesg output posted on the Bugzilla report, it looks
> like although bladud's machine has multiple controller instances, Joe
> Sapp's only has one, so that can't be the problem there.

Agree.

> 
> I can't tell about bladud's machine but Joe Sapp's is using SWNCQ

Well, we definitely need bladud to give us the *full* dmesg :-)

> mode. Looking at the nv_swncq_port_suspend and nv_swncq_port_resume
> functions in sata_nv, they seem suspicious. They seem to act more
> globally than the port they are called for, doing things like
> disabling interrupts and SWNCQ mode for all ports on that host. It
> appears that if any of the ports on a host was suspended, all of them
> would be disabled.

Glad to know this, thanks.

I would like Joe to run the debug patch too, see if ata2 is suspended
first, that may cause ata port 1, where the only disk is attached, stops
working.

> 
> It looks like it would be fixable, though since there's no proper
> public docs on this chipset it would be done kind of blindly.

+KuanLuo@nvidia and PeerChen@nvidia and pray their email addresses are
still valid.

Hi Kuan and Peer,
We have seen bug report on suspend problem for NVIDIA MCP 5x controller
here:
https://bugzilla.kernel.org/show_bug.cgi?id=48951
And it looks like to us, if swncq is in use, the port suspend function
will disable irq for all ports on this host. Is this the case? And if
yes, can you please fix it? Thanks.

Thanks,
Aaron
