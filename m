From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH libata-dev-2.6 04/05] libata: support descriptor sense
 in ctrl page
Date: Tue, 22 Mar 2005 23:24:58 -0500
Message-ID: <4240EF9A.7050701@pobox.com>
References: <20050317221753.53957EDF@lns1032.lss.emc.com> <20050317221753.D65B81E4@lns1032.lss.emc.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:22401 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S262773AbVCWEZK (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 22 Mar 2005 23:25:10 -0500
In-Reply-To: <20050317221753.D65B81E4@lns1032.lss.emc.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Brett Russ <russb@emc.com>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

Brett Russ wrote:
> 04_libata_control_pg_desc_bit.patch
> 
> 	libata must support the descriptor format sense blocks as they
> 	are required to properly report results of ATA pass through
> 	commands as well as other SCSI commands reporting 48b LBAs.
> 	This patch adjusts the control mode page to properly report
> 	this.
> 
> Signed-off-by: Brett Russ <russb@emc.com>

applied


