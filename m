From: Peter Dons Tychsen <donpedro@tdcadsl.dk>
Subject: Re: STANDBY IMMEDIATE failed on NVIDIA MCP5x controllers when
 system suspend
Date: Wed, 13 Mar 2013 00:21:02 +0100
Message-ID: <1363130462.4669.31.camel@donpedro.P-2601HN-F1>
References: <513D52BE.7040307@intel.com>
	 <1363032071.4669.9.camel@donpedro.P-2601HN-F1> <513E9444.1090104@intel.com>
Reply-To: donpedro@tdcadsl.dk
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp2.cybercity.dk ([212.242.43.252]:57016 "EHLO
	smtp2.cybercity.dk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754198Ab3CLXVG (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 12 Mar 2013 19:21:06 -0400
In-Reply-To: <513E9444.1090104@intel.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Aaron Lu <aaron.lu@intel.com>
Cc: bladud@gmail.com, Joe Sapp <nixphoeni+kernel@gmail.com>, Alberto Mattea <support.intranet@libero.it>, Robert Hancock <hancockrwd@gmail.com>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, Tejun Heo <tj@kernel.org>, Jeff Garzik <jgarzik@pobox.com>

Hello again,

On Tue, 2013-03-12 at 10:34 +0800, Aaron Lu wrote:
> The device that is responsible for PM operations for the disk is named
> something like sd X:0:0:0, where X is the host number, and is normally
> attached under the ata port number+1. So sd 2:0:0:0 is attached to ata
> port 3(if there are USB disks, things may change). And the ata port
> device is reponsible for ata port level PM operations like power off
> the
> port etc., and its device is named as atax, where x is its port
> number.
> So you can see from the log, only after sd 4:0:0:0 and sd 2:0:0:0
> failed
> in their ->suspend function, ata5 and ata3's suspend functions start
> to
> run, and then sata_nv 0000:00:05.1 starts to run.

Yes, but 1 thing completes before disks are suspended:

[ 7378.237631] sata_nv 0000:00:05.2: __device_suspend: starts
[ 7378.249333] sata_nv 0000:00:05.2: __device_suspend: done

And then sd 2:0:0:0 starts to suspend.

This might be correct seen from a dependency point of view. But what if
the HW designer was a bit lazy (or saved a bit of logic), and performs
some sort of shutdown when the first function (0000:00:05.2) is
suspended? That would require all disks attached to be dependent on all
functions.

If it is the case (which would not surprise me), is it possible to
describe such dependencies in the PM?

Thanks,

/pedro

