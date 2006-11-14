From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH] sata_vsc: s/host_set/host/
Date: Tue, 14 Nov 2006 13:45:47 -0500
Message-ID: <455A0EDB.5050705@pobox.com>
References: <20061109030304.GY13677@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:40391 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S933470AbWKNSpv (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 14 Nov 2006 13:45:51 -0500
In-Reply-To: <20061109030304.GY13677@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: linux-ide@vger.kernel.org

Tejun Heo wrote:
> sata_vsc MSI support merge brought in now renamed host_set and breaks
> build.  s/host_set/host/
> 
> Signed-off-by: Tejun Heo <htejun@gmail.com>

applied


