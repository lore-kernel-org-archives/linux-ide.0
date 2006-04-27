From: Jan Dittmer <jdi@l4x.org>
Subject: Re: sata_sil24 resetting controller...
Date: Thu, 27 Apr 2006 21:21:49 +0200
Message-ID: <445119CD.40509@l4x.org>
References: <20060427185813.GB6039@l4x.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from 10.121.9.213.dsl.getacom.de ([213.9.121.10]:11712 "EHLO
	ds666.l4x.org") by vger.kernel.org with ESMTP id S965008AbWD0TVy
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 27 Apr 2006 15:21:54 -0400
In-Reply-To: <20060427185813.GB6039@l4x.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com
Cc: jdi@l4x.org, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

jdi@l4x.org wrote:
> so I started to reshape my raid5 array. Since the reshape
> started my kernel log gets swamped with the following messages:
> 
> [4297871.909000] sata_sil24 ata1: resetting controller...
> [4297871.909000] ata1: status=0x50 { DriveReady SeekComplete }
> [4297871.909000] sdc: Current: sense key=0x0
> [4297871.909000]     ASC=0x0 ASCQ=0x0
> [4297873.266000] ata1: error interrupt on port0
> [4297873.266000]   stat=0x80000001 irq=0xb60002 cmd_err=35 sstatus=0x123
> serror=0x0
> 
> The time between these events varies from .5s to up to 10s, resync speed is

Just one more observation:
The time between the messages seems to be correlated to the resync speed.
The faster the resync, the more messages.

Jan
