From: Mark Lord <kernel@teksavvy.com>
Subject: Re: libata: init ata_print_id to 0
Date: Mon, 23 Apr 2012 11:32:57 -0400
Message-ID: <4F957629.1050102@teksavvy.com>
References: <alpine.LFD.2.02.1204221136450.1947@terrop>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ironport-out.teksavvy.com ([206.248.143.162]:10615 "EHLO
	ironport-out.teksavvy.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752961Ab2DWPc6 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 23 Apr 2012 11:32:58 -0400
In-Reply-To: <alpine.LFD.2.02.1204221136450.1947@terrop>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tero Roponen <tero.roponen@gmail.com>
Cc: linux-ide@vger.kernel.org, Dan Williams <dan.j.williams@intel.com>, Jeff Garzik <jgarzik@redhat.com>

On 12-04-22 04:38 AM, Tero Roponen wrote:
..
> The change of numbering comes from commit 85d6725b7c0d7e3f ("libata:
> make ata_print_id atomic") that changed lines like
> 
> 	ap->print_id = ata_print_id++;
> 		to
> 	ap->print_id = atomic_inc_return(&ata_print_id);
> 
> As the latter behaves like ++ata_print_id, we must initialize
> it to zero to start the numbering from one.

Darn!  And here I though we'd finally end up with libata numbering
matching the scsi host numbering (on most systems).  :)

