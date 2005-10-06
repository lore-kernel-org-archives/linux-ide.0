From: Brett Russ <russb@emc.com>
Subject: Re: [PATCH 2.6.14-rc2 0/2] libata: Marvell SATA support (v0.23-0.24)
Date: Thu, 06 Oct 2005 09:31:39 -0400
Message-ID: <4345273B.40906@emc.com>
References: <20051005210610.EC31826369@lns1058.lss.emc.com> <Pine.LNX.4.63.0510061441050.3140@dingo.iwr.uni-heidelberg.de> <43452315.7050801@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1750920AbVJFNbx@vger.kernel.org>
In-Reply-To: <43452315.7050801@pobox.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Bogdan Costescu <Bogdan.Costescu@iwr.uni-heidelberg.de>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

Jeff Garzik wrote:
> Staring at the docs a bit, I notice that the 50xx and 60xx have SATA 
> S{status,control,error} registers at different locations.


Yes and also even some registers that are at the same location have 
changed bit definitions.  Aye caramba.

Best solution will probably be to create separate enums for each chip 
generation, in addition to a common enum, and point to the relevant one 
based on the chip identifier.

No surprise we're seeing so many problems.  I have just not spent any 
time at all on 5xxx.  Probably should yank it from the pci device table 
for now.

BR
