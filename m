From: Thomas Rohwer <tr@tng.de>
Subject: Re: Hang during boot in piix_init_pcs (ata_piix.c) with macbook pro
Date: Mon, 19 Nov 2007 13:59:21 +0100
Message-ID: <474188A9.3020701@tng.de>
References: <47371586.9090409@tng.de> <47386F3E.8000906@gmail.com> <47407DD8.10301@tng.de> <47412E96.6070701@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from liadriel1.tng.de ([213.178.66.91]:57604 "EHLO smtp.tng.de"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752498AbXKSM7Y (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 19 Nov 2007 07:59:24 -0500
In-Reply-To: <47412E96.6070701@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: linux-ide@vger.kernel.org, "Gaston, Jason D" <jason.d.gaston@intel.com>

> One question.  Does macbook's firmware allow putting the controller into
> ahci mode?

Do you mean, that one can configure the firmware, so that it puts the
controller in ahci mode during boot? I don't know. There seems to be no user interface
for the firmware. The refit bootloader is able to manipulate efi setting
variables, but one would need some documentation to understand the meaning of them.

Or do you mean, that one can switch to ahci mode under linux?

Sincerely,

Thomas Rohwer
