Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E065E15B14C
	for <linux-ide@vger.kernel.org>; Mon, 29 Jul 2024 14:35:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722263724; cv=none; b=fsaiTCWfH/4KntXdNLuhAERK32nZsDaCbTSuAFJoG510ESzda4+Y5uQr4GFgI1gPXPx2k/W0DTM7kVD7JivH/+NyeAeKuuNPNgu/lHdhPWVp0/3S8rZgSdEqV0Q8e5RRZZ2dLKod+eim7ysYiBuXWaKxPheT+g+TaJ9xHE3B7ME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722263724; c=relaxed/simple;
	bh=1m/iHnY596PqItA68AiGUlkHlFhLXFBV/A2Ovmejxi8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UFfpABbeVYu5Z0Oe7Zppr+BnRurv6phIT5qRJXnN7/B0wbln4IhepJjP9UfA6wMOx8jerSPmoI1juM/cs2AKvy00Offi68HT/jGi4hz/kGd4WZsCpEPKWqK7MalYLfnCGRvZlI5sxQK+4+wllhOQnlhmuQvnkFCNkSTlgom1DxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 411AA68D05; Mon, 29 Jul 2024 16:35:19 +0200 (CEST)
Date: Mon, 29 Jul 2024 16:35:19 +0200
From: Christoph Hellwig <hch@lst.de>
To: Christian Lamparter <chunkeey@gmail.com>
Cc: axboe@kernel.dk, Niklas Cassel <cassel@kernel.org>,
	linux-ide@vger.kernel.org
Subject: Re: [PATCH 04/15] block: add an API to atomically update queue
 limits
Message-ID: <20240729143519.GA28235@lst.de>
References: <20240213073425.1621680-5-hch@lst.de> <2011786.tdWV9SEqCh@shift>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2011786.tdWV9SEqCh@shift>
User-Agent: Mutt/1.5.17 (2007-11-01)

[switching Cc lists to be more relevant]

Hi Christian,

this is another case where the block layer previously warned about
somethign that it enforces now.  Switch the dma_boundary in
sata_dwc_sht to 16k (patch below) will "fix" this, but it directly
contradicts the comment next to that field.

---
diff --git a/drivers/ata/sata_dwc_460ex.c b/drivers/ata/sata_dwc_460ex.c
index 52f5168e4db542..4c182694ba51d1 100644
--- a/drivers/ata/sata_dwc_460ex.c
+++ b/drivers/ata/sata_dwc_460ex.c
@@ -1089,8 +1089,10 @@ static const struct scsi_host_template sata_dwc_sht = {
 	 * boundary. If the block spans such a FIS boundary, there is a chance
 	 * that a DMA burst will cross that boundary -- this results in an
 	 * error in the host controller.
+	 *
+	 * XXX
 	 */
-	.dma_boundary		= 0x1fff /* ATA_DMA_BOUNDARY */,
+	.dma_boundary		= SZ_16K - 1,
 };
 
 static struct ata_port_operations sata_dwc_ops = {
