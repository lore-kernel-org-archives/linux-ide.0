From: "J. Ryan Earl" <heretic@clanhk.org>
Subject: Re: Status of the sata_sil driver for the VT8237
Date: Sun, 28 Mar 2004 01:48:11 -0600
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <4066833B.4080004@clanhk.org>
References: <4066342B.4080105@clanhk.org> <406643A8.2050808@pobox.com> <40664AE4.8010003@clanhk.org> <406680AB.8090204@stesmi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ns.clanhk.org ([69.93.101.154]:40623 "EHLO mail.clanhk.org")
	by vger.kernel.org with ESMTP id S262119AbUC1HsB (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 28 Mar 2004 02:48:01 -0500
In-Reply-To: <406680AB.8090204@stesmi.com>
List-Id: linux-ide@vger.kernel.org
To: Stefan Smietanowski <stesmi@stesmi.com>
Cc: Jeff Garzik <jgarzik@pobox.com>, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

Stefan Smietanowski wrote:

> Many A64 boards today come with a Promise SATA controller as well -
> works like a charm for me on an ASUS K8V Deluxe board here.

That's an option, as is just using the sii3112 that's been working so 
well, but that still puts the disks on the PCI bus.  The whole point is 
to get 300MB/sec of burstable I/O off the 133MB/s bus that's shared with 
the dual gigE controllers and a firewire camera.

-ryan
