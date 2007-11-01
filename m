From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: sata_nv: ata2 errors
Date: Thu, 1 Nov 2007 13:31:02 -0700
Message-ID: <20071101133102.1121bc28.akpm@linux-foundation.org>
References: <877aabc40710250048m41675163x81671097f44bba7f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp2.linux-foundation.org ([207.189.120.14]:48321 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752636AbXKAUbG (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 1 Nov 2007 16:31:06 -0400
In-Reply-To: <877aabc40710250048m41675163x81671097f44bba7f@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Amit Shah <shahamit@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

On Thu, 25 Oct 2007 13:18:50 +0530
"Amit Shah" <shahamit@gmail.com> wrote:

> On 2.6.24-rc1 (AMD Opteron 1216), my sata_nv driver produces this
> output on bootup:
> 
> ata2: EH in SWNCQ mode,QC:qc_active 0x1 sactive 0x1
> ata2: SWNCQ:qc_active 0x1 defer_bits 0x0 last_issue_tag 0x0
> ata2: ATA_REG 0x40 ERR_REG 0x0
> ata2: tag : dhfis dmafis sdbfis sacitve
> ata2: tag 0x0: 0 1 0 0
> ata2.00: exception Emask 0x0 SAct 0x1 SErr 0x0 action 0x6 frozen
> ...
> ata2.00: status: { DRDY }
> 

Are any other problems observeable?

Did 2.6.23 do this?
