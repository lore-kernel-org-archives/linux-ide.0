From: Aaron Lu <aaron.lu@intel.com>
Subject: Re: STANDBY IMMEDIATE failed on NVIDIA MCP5x controllers when system
 suspend
Date: Wed, 13 Mar 2013 13:41:01 +0800
Message-ID: <5140116D.6050805@intel.com>
References: <513D52BE.7040307@intel.com> <1363032071.4669.9.camel@donpedro.P-2601HN-F1> <513E9444.1090104@intel.com> <1363130462.4669.31.camel@donpedro.P-2601HN-F1> <CADLC3L28BQmwjicnA86zA4Tf42O9MygauNdnK2SanqazwtgpoQ@mail.gmail.com> <513FE639.90401@intel.com> <CAKRKD_WaSxtgaDWF3dQu=U_8bRYAy8UmovNzai2+1wHm9OVRyQ@mail.gmail.com> <51400986.5040607@intel.com> <CAKRKD_U+o_ikoszn+bVtEQXas3zwK7tkxp2wM3nyhD2eC3A3jA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:34545 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754711Ab3CMFj6 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 13 Mar 2013 01:39:58 -0400
In-Reply-To: <CAKRKD_U+o_ikoszn+bVtEQXas3zwK7tkxp2wM3nyhD2eC3A3jA@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Simeon Bird <bladud@gmail.com>
Cc: Robert Hancock <hancockrwd@gmail.com>, Kuan Luo <kluo@nvidia.com>, Peer Chen <pchen@nvidia.com>, donpedro@tdcadsl.dk, Joe Sapp <nixphoeni+kernel@gmail.com>, Alberto Mattea <support.intranet@libero.it>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, Tejun Heo <tj@kernel.org>, Jeff Garzik <jgarzik@pobox.com>

On 03/13/2013 01:16 PM, Simeon Bird wrote:
>> And also full dmesg for the failed case please, thanks.
> 
> Done (but it is the same boot, so includes the successful case as a subset)
> 
OK, thanks.

So here is the relationship:
  0000:00:05.0			0000:00:05.1		0000:00:05.2
ata1       ata2		    ata3	ata4		ata5    ata6
sd 0:0:0:0 sd 1:0:0:0	    sd 2:0:0:0  sd 3:0:0:0	no disks attched

and ata3's suspend callback is done before sd 3:0:0:0's suspend callback
is finished, and as Robert analyzed, the port suspend callback masked
all isr for the controller, which makes the STANDBY IMMEDIATE command
for sd 3:0:0:0 timedout. The same is true for sd 0:0:0:0, where ata2 is
done before its suspend callback.

So I think Robert's analysis is right, there is a bug in
nv_swncq_port_suspend.

Thanks,
Aaron

