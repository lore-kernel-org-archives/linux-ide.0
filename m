From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH] libata: HPA support
Date: Tue, 17 Apr 2007 16:42:41 -0400
Message-ID: <46253141.80509@pobox.com>
References: <20070411002313.29069ca5@the-village.bc.nu> <46251CCB.9040906@pobox.com> <20070417193057.GB22688@redhat.com> <200704171534.56685.jkeating@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:42769 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932382AbXDQUmp (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 17 Apr 2007 16:42:45 -0400
In-Reply-To: <200704171534.56685.jkeating@redhat.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jesse Keating <jkeating@redhat.com>
Cc: Dave Jones <davej@redhat.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-ide@vger.kernel.org

Jesse Keating wrote:
> On Tuesday 17 April 2007 15:30:57 Dave Jones wrote:
>> jesse, wanna give that a shot? booting with the installer with
>> sata_nv.adma=0 should do the trick.
> 
> That didn't effect anything.  I still saw a message about "using ADMA mode" 
> right before the panic(s).
> 
> I added "sata_nv.adma=0" to the kernel arguments.

If you still saw ADMA mode, then it's not seeing the module parameter.

It sounds like putting sata_nv.adma on the kernel command line didn't do 
the trick?

	Jeff



