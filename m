From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH libata-dev-2.6 1/3] Add CHS support
Date: Fri, 18 Feb 2005 18:40:13 -0500
Message-ID: <42167CDD.50301@pobox.com>
References: <006d01c50c11$81003920$a801a8c0@tw.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:48025 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S261544AbVBRXkh (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 18 Feb 2005 18:40:37 -0500
In-Reply-To: <006d01c50c11$81003920$a801a8c0@tw.ibm.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Albert Lee <albertcc@tw.ibm.com>
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, Doug Maxey <dwm@maxeymade.com>, IDE Linux <linux-ide@vger.kernel.org>, Mark Lord <mlord@pobox.com>

Applied patches 1 and 2 of the first CHS series,
and patches 3-1 through 3-3 of the second CHS series, to libata-dev queue.

As a follow-up, I believe libata-core should be modified to issue the
INITIALIZE DEVICE PARAMETERS command for all CHS devices.

Thanks,

	Jeff


