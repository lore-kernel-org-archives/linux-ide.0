From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [patch 1/3] libata: check for AN support
Date: Wed, 28 Mar 2007 22:02:12 -0400
Message-ID: <460B1E24.3080502@pobox.com>
References: <20070328230108.597741522@intel.com> <20070328164443.9fc8b924.kristen.c.accardi@intel.com> <460B1C06.6040808@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:49559 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965884AbXC2CCQ (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 28 Mar 2007 22:02:16 -0400
In-Reply-To: <460B1C06.6040808@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Kristen Carlson Accardi <kristen.c.accardi@intel.com>, linux-kernel@vger.kernel.org, akpm@linux-foundation.org, linux-ide@vger.kernel.org

Tejun Heo wrote:
> Kristen Carlson Accardi wrote:
>> Check to see if an ATAPI device supports Asynchronous Notification.
>> If so, enable it.
> 
> As supporting AN needs host interrupt handler change.  I think we need 
> host-supports-AN flag; otherwise, we might end up with screaming 
> interrupts in the worst case.

Quite so.  Lacking a host flag, we need to know how each and every 
controller behaves when AN is activated (and supported by the device). 
I'm willing to bet some of the first-gen SATA controllers' ASIC state 
machines croak when AN is activated.

	Jeff



