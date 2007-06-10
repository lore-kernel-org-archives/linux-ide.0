From: Mark Lord <liml@rtr.ca>
Subject: Re: 2.6.22-rc regression: smartctl does not work with SATA disk
Date: Sun, 10 Jun 2007 18:33:25 -0400
Message-ID: <466C7C35.7020105@rtr.ca>
References: <Pine.LNX.4.64.0706101049130.6348@kai.makisara.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([64.26.128.89]:2505 "EHLO mail.rtr.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760062AbXFJWd1 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 10 Jun 2007 18:33:27 -0400
In-Reply-To: <Pine.LNX.4.64.0706101049130.6348@kai.makisara.local>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Kai Makisara <Kai.Makisara@kolumbus.fi>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

Kai Makisara wrote:
> The command 'smartctl -a /dev/sdb' fails with 2.6.22-rc4 kernel. The 
> disk /dev/sdb is a SATA disk. The command does work still with a real SCSI 
> disk.

Last time I checked, one must supply the "-d ata" parameter to smartctl
for it to work with libata drives.  Has this changed?
