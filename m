From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH] Small initializer patch for ide-disk.c
Date: Tue, 21 Dec 2004 16:02:43 -0500
Message-ID: <41C88F73.2090606@pobox.com>
References: <20041221202407.GD2725@artsapartment.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:8881 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S261603AbULUVCu
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 21 Dec 2004 16:02:50 -0500
In-Reply-To: <20041221202407.GD2725@artsapartment.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Art Haas <ahaas@airmail.net>
Cc: Andrew Morton <akpm@osdl.org>, Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>, linux-ide@vger.kernel.org

Art Haas wrote:
> Hi.
> 
> This patch adds C99 initializers to the file. It can clearly wait until
> after 2.6.10 is released if you want to send it to Linus.

The unpatched version is far more readable and maintainable.

	Jeff



