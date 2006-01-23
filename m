From: Arjan van de Ven <arjan@infradead.org>
Subject: Re: [PATCH 07/13] SCSI: export scsi_eh_finish_cmd() and
	scsi_eh_flush_done_q()
Date: Mon, 23 Jan 2006 08:26:00 +0100
Message-ID: <1138001160.2977.14.camel@laptopd505.fenrus.org>
References: <11379893764141-git-send-email-htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-scsi-owner@vger.kernel.org>
In-Reply-To: <11379893764141-git-send-email-htejun@gmail.com>
Sender: linux-scsi-owner@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: James.Bottomley@SteelEye.com, linux-scsi@vger.kernel.org, albertcc@tw.ibm.com, linux-ide@vger.kernel.org, jgarzik@pobox.com
List-Id: linux-ide@vger.kernel.org

On Mon, 2006-01-23 at 13:09 +0900, Tejun Heo wrote:
> Export two SCSI EH command handling functions.  To be used by libata EH.


since these are pretty much internal, can we make these _GPL exports?

