From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH 2.6.9-libata1-dev1] sata_promise: pdc20619 support
Date: Sat, 30 Oct 2004 08:44:36 -0400
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <41838CB4.6090100@pobox.com>
References: <1098489319.2992.48.camel@server.lorenz.priv>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:22674 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S261154AbUJ3Mot
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 30 Oct 2004 08:44:49 -0400
In-Reply-To: <1098489319.2992.48.camel@server.lorenz.priv>
List-Id: linux-ide@vger.kernel.org
To: Tobias Lorenz <tobias.lorenz@gmx.net>
Cc: linux-ide@vger.kernel.org

Can I ask you to do one further task on this patch:  split it up into 
two patches:  1) rename s/sata/ata/ symbols, etc.  2) implement pdc20619 
supports

Obviously patch #2 will depend on patch #1.

Thanks,

	Jeff



