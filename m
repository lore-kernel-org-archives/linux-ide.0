From: Mark Lord <lkml@rtr.ca>
Subject: Re: sata_nv + ADMA + Samsung disk problem
Date: Wed, 02 Jan 2008 23:14:02 -0500
Message-ID: <477C610A.30805@rtr.ca>
References: <20070808120804.GB5257@boogie.lpds.sztaki.hu> <20080101164416.GA29574@boogie.lpds.sztaki.hu> <477B0429.7040909@gmail.com> <477B0CFD.1030603@shaw.ca> <F72FA20C31DD4F4C997B91C5B3690A09505577@hqemmail07.nvidia.com> <477BDEA5.8040701@garzik.org> <F72FA20C31DD4F4C997B91C5B3690A0950557D@hqemmail07.nvidia.com> <477C2A99.9010208@shaw.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1758725AbYACEOT@vger.kernel.org>
In-Reply-To: <477C2A99.9010208@shaw.ca>
Sender: linux-kernel-owner@vger.kernel.org
To: Robert Hancock <hancockr@shaw.ca>
Cc: Allen Martin <AMartin@nvidia.com>, Jeff Garzik <jeff@garzik.org>, Tejun Heo <htejun@gmail.com>, Gabor Gombas <gombasg@sztaki.hu>, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, Kuan Luo <kluo@nvidia.com>, Peer Chen <pchen@nvidia.com>
List-Id: linux-ide@vger.kernel.org

Robert Hancock wrote:
>
> What we're doing to enter legacy mode is essentially:
> 
> -wait until ADMA status indicates IDLE bit set (max wait of 1 microsecond)
> -clear GO bit in control register
> -wait until status indicates LEGACY bit set (max wait of 1 microsecond)
> 
> and to enter ADMA mode:
> 
> -set GO bit in control register
> -wait until status indicates LEGACY bit cleared and IDLE bit set (max 
> wait of 1 microsecond)
..

If there are outstanding TCQ/NCQ commands (any drive),
then this could take (much) longer to enter legacy mode,
as the ADMA engine will wait for them all to finish.

But for normal, "nothing outstanding" mode, it should be very quick.

Cheers
