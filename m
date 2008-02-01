From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [2.6 patch] ata_piix.c: make piix_merge_scr() static
Date: Fri, 01 Feb 2008 11:55:42 -0500
Message-ID: <47A34F0E.104@garzik.org>
References: <20080128221019.GN8767@does.not.exist>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:60641 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755212AbYBAQzq (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 1 Feb 2008 11:55:46 -0500
In-Reply-To: <20080128221019.GN8767@does.not.exist>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Adrian Bunk <bunk@kernel.org>
Cc: Tejun Heo <htejun@gmail.com>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

Adrian Bunk wrote:
> piix_merge_scr() can become static.
> 
> Signed-off-by: Adrian Bunk <bunk@kernel.org>

applied


