From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH 02/21] libata: add @is_cmd to ata_tf_to_fis()
Date: Fri, 20 Jul 2007 07:56:59 -0400
Message-ID: <46A0A30B.3080702@garzik.org>
References: <1184563778203-git-send-email-htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:49843 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753281AbXGTL5B (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 20 Jul 2007 07:57:01 -0400
In-Reply-To: <1184563778203-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-ide@vger.kernel.org, Forrest Zhao <forrest.zhao@gmail.com>

Tejun Heo wrote:
> +extern void ata_tf_to_fis(const struct ata_taskfile *tf,
> +			  u8 pmp, int is_cmd, u8 *fis);


I'm applying these... but I would like to start seeing 'bool' type used 
for arguments like "is_cmd", for situations where the only values we 
-ever- care about are true or false.

I really feel the "bool" type makes function prototypes more readable, 
in particular.

	Jeff



