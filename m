From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [IDE] new driver: ADMA
Date: Wed, 17 Nov 2004 00:05:46 -0500
Message-ID: <419ADC2A.8020007@pobox.com>
References: <20041117045809.GA1792@havoc.gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:44177 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S262168AbUKQFF6
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 17 Nov 2004 00:05:58 -0500
In-Reply-To: <20041117045809.GA1792@havoc.gtf.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, mlord@pobox.com, linville@tuxdriver.com

oh, and a quick data point:  ata_adma.c is a non-queueing driver (for now).

