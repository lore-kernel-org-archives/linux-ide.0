From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: ata_bmdma_* calls in libata-core.c
Date: Wed, 02 Feb 2005 15:00:14 -0500
Message-ID: <4201314E.1060502@pobox.com>
References: <001001c50960$049a7930$3805040a@internal.synopsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:20690 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S262579AbVBBUA2 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 2 Feb 2005 15:00:28 -0500
In-Reply-To: <001001c50960$049a7930$3805040a@internal.synopsys.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mat.Loikkanen@synopsys.com
Cc: linux-ide@vger.kernel.org

Mat Loikkanen wrote:
> I suggest all BMDMA calls become callbacks that the driver can set to its
> own functions or assign to wrapper functions implemented in libata-core.c
> that call the inline functions in libata.h.  Should I do this?


Yeah, that works for me.

	Jeff


