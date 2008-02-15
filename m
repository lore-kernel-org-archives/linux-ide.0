From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH 01/11] ata: fix sparse warning in ata_piix.c
Date: Fri, 15 Feb 2008 13:51:58 -0500
Message-ID: <47B5DF4E.5040407@garzik.org>
References: <1202966045.2748.15.camel@brick>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:54632 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754674AbYBOSwA (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 15 Feb 2008 13:52:00 -0500
In-Reply-To: <1202966045.2748.15.camel@brick>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Harvey Harrison <harvey.harrison@gmail.com>
Cc: Tejun Heo <htejun@gmail.com>, LKML <linux-kernel@vger.kernel.org>, linux-ide <linux-ide@vger.kernel.org>

Harvey Harrison wrote:
> drivers/ata/ata_piix.c:1655:8: warning: symbol 'rc' shadows an earlier one
> drivers/ata/ata_piix.c:1616:6: originally declared here
> 
> Signed-off-by: Harvey Harrison <harvey.harrison@gmail.com>
> ---
>  drivers/ata/ata_piix.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)

applied 1-4


