From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [2.6 patch] drivers/ata/: make 4 functions static
Date: Tue, 09 Jan 2007 05:42:06 -0500
Message-ID: <45A3717E.1060603@pobox.com>
References: <20070103230936.GR20714@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:33605 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751306AbXAIKmJ (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 9 Jan 2007 05:42:09 -0500
In-Reply-To: <20070103230936.GR20714@stusta.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Adrian Bunk <bunk@stusta.de>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

Adrian Bunk wrote:
> This patch makes the following needlessly global functions static:
> - libata-core.c: ata_qc_complete_internal()
> - libata-scsi.c: ata_scsi_qc_new()
> - libata-scsi.c: ata_dump_status()
> - libata-scsi.c: ata_to_sense_error()
> 
> Signed-off-by: Adrian Bunk <bunk@stusta.de>

applied


