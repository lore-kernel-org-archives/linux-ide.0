From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [patch 1/2] fastboot: Add a module parameter to skip probing of
 specific ports
Date: Tue, 12 Aug 2008 15:21:00 +0100
Message-ID: <20080812152100.0123a2e1@lxorguk.ukuu.org.uk>
References: <20080811153542.61095e5c@infradead.org>
	<20080811153641.706726ec@infradead.org>
	<20080812083903.6d402c2e@lxorguk.ukuu.org.uk>
	<20080812043603.3d8471d4@infradead.org>
	<20080812130027.2c4643a9@lxorguk.ukuu.org.uk>
	<20080812070222.3dc9efcb@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1753742AbYHLOik@vger.kernel.org>
In-Reply-To: <20080812070222.3dc9efcb@infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Arjan van de Ven <arjan@infradead.org>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

> and can add the option for this case. It's the "push policy out of the
> kernel" thing.. while the kernel probably can't know this (and you're
> right, the DMI patch is thus the wrong thing to do).. the admin can.

libata lets you set the nth controller to various things (40wire etc) so
I suspect the right thing to extent is the existing libata option code
that Tejun wrote to include 'skip' if it doesn't already.

If that gets done cc me and I'll then go audit the drivers to see who
apart from it821x knows port 0 is always probed
