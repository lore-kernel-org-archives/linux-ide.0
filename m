From: James Bottomley <James.Bottomley@SteelEye.com>
Subject: Re: ipr SATA problems in 2.6.20
Date: Tue, 16 Jan 2007 17:30:25 -0600
Message-ID: <1168990225.2789.22.camel@mulgrave.il.steeleye.com>
References: <45AD50AD.2040700@linux.vnet.ibm.com>
	 <20070116224115.50d29cf7@localhost.localdomain>  <45AD55A4.50208@pobox.com>
	 <1168989094.2789.20.camel@mulgrave.il.steeleye.com>
	 <45AD5D27.8020004@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-scsi-owner@vger.kernel.org>
In-Reply-To: <45AD5D27.8020004@linux.vnet.ibm.com>
Sender: linux-scsi-owner@vger.kernel.org
To: brking@linux.vnet.ibm.com
Cc: Jeff Garzik <jgarzik@pobox.com>, Alan <alan@lxorguk.ukuu.org.uk>, linux-scsi@vger.kernel.org, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, Tejun Heo <htejun@gmail.com>
List-Id: linux-ide@vger.kernel.org

On Tue, 2007-01-16 at 17:17 -0600, Brian King wrote:
> I think we are OK here since atapi_xlate is only ever called by
> ata_scsi_translate.

True.  But can you tell me where it gets set in ata_scsi_translate if
sc_data_direction is DMA_NONE ...

James


