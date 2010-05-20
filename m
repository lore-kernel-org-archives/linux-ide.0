From: Tejun Heo <tj@kernel.org>
Subject: Re: Strange read data corruption on ext4/LVM/md
Date: Thu, 20 May 2010 10:57:29 +0200
Message-ID: <4BF4F979.4070903@kernel.org>
References: <20100519225653.1fedb453@mjolnir.ossman.eu>	<20100519230426.47c6c1ed@mjolnir.ossman.eu>	<20100519232906.3be82279@mjolnir.ossman.eu>	<20100519233408.7436bd9b@mjolnir.ossman.eu> <20100520091429.192d560c@mjolnir.ossman.eu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20100520091429.192d560c@mjolnir.ossman.eu>
Sender: linux-kernel-owner@vger.kernel.org
To: Pierre Ossman <pierre-list@ossman.eu>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

On 05/20/2010 09:14 AM, Pierre Ossman wrote:
> Note that this is a live system, so there is some chance that something
> wrote to than area, then restored it to the previous state. I'm not
> sure how likely that is.
> 
> If not, then it would seem that this is a problem in either the disks,
> the controller or the controller driver. The components are WD
> WD1002FAEX, sil3132 and sata_sil24 respectively.

There is a report that sil3124/32 recognizes FIS corruption but keeps
using the payload anyway thus leading to data corruption when the bus
condition on pci-e side isn't ideal.  Does moving the controller to
different slot make difference?

Thanks.

-- 
tejun
