From: Daniel Walker <dwalker@fifo99.com>
Subject: Re: [PATCH] libata: Add pata_atp867x driver for Artop/Acard
 ATP867X controllers
Date: Fri, 11 Sep 2009 19:14:01 -0700
Message-ID: <1252721641.28368.34.camel@desktop>
References: <8b5805ff0909111906j68c20c3yf7226f2798a67d80@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fifo99.com ([67.223.236.141]:47307 "EHLO fifo99.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757172AbZILCN0 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 11 Sep 2009 22:13:26 -0400
In-Reply-To: <8b5805ff0909111906j68c20c3yf7226f2798a67d80@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "Jung-Ik (John) Lee" <jilee@google.com>
Cc: Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, Grant Grundler <grundler@google.com>, Gwendal Grignou <gwendal@google.com>, Eric Uhrhane <ericu@google.com>

On Fri, 2009-09-11 at 19:06 -0700, Jung-Ik (John) Lee wrote:
> From: John(Jung-Ik) Lee <jilee@google.com>
> 
> This is a new pata driver for ARTOP 867X 64bit 4-channel UDMA133 ATA
> ctrls.
> Based on the Atp867 data sheet rev 1.2, Acard, and in part on early
> ide codes
> from Eric Uhrhane <ericu@google.com>.

This driver has numerous checkpatch errors .. Could you run this though
scripts/checkpatch.pl and correct anything it finds?

Daniel

