From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: sata optical drive, i865 and 2.6.10
Date: Sun, 26 Dec 2004 19:45:47 -0500
Message-ID: <41CF5B3B.5060008@pobox.com>
References: <20041227002534.3204436957@irc.ptitlu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:35208 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S261462AbUL0Apz
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 26 Dec 2004 19:45:55 -0500
In-Reply-To: <20041227002534.3204436957@irc.ptitlu.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: P'tit Lu <ptitlu@ptitlu.org>
Cc: linux-ide@vger.kernel.org

#define this, at the top of include/linux/libata.h:

#undef ATA_ENABLE_ATAPI         /* define to enable ATAPI support */

