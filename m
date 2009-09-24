From: Frans Pop <elendil@planet.nl>
Subject: Re: 2.6.{30,31} x86_64 ahci problem - irq 23: nobody cared
Date: Thu, 24 Sep 2009 21:40:08 +0200
Message-ID: <200909242140.10174.elendil@planet.nl>
References: <4ABBB8C2.2080901@sbg.ac.at> <200909242124.42187.elendil@planet.nl>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1753000AbZIXTkJ@vger.kernel.org>
In-Reply-To: <200909242124.42187.elendil@planet.nl>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Alexander Huemer <alexander.huemer@sbg.ac.at>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

On Thursday 24 September 2009, Frans Pop wrote:
> > error message from .31:
> >  [157152.418524] irq 23: nobody cared
>
> If no others reply and the issue can be reproduced reliably, running a
> git bisect between v2.6.29 and v2.6.30 to trace the cause of the
> regression could be an option.

Looking at the changes in drivers/ata/ahci.c, it might be worth to try if 
reverting the following commit fixes the issue:

commit a5bfc4714b3f01365aef89a92673f2ceb1ccf246
Author: Tejun Heo <tj@kernel.org>
Date:   Fri Jan 23 11:31:39 2009 +0900

    ahci: drop intx manipulation on msi enable

It's a bit of a wild guess though.
