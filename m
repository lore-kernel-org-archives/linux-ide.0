From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH 2/2] libata: implement setting _SDD
Date: Wed, 09 Aug 2006 00:41:39 -0400
Message-ID: <44D96783.7010701@pobox.com>
References: <1153899440.4957.62.camel@forrest26.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:30621 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1030467AbWHIEll (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 9 Aug 2006 00:41:41 -0400
In-Reply-To: <1153899440.4957.62.camel@forrest26.sh.intel.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "zhao, forrest" <forrest.zhao@intel.com>
Cc: rdunlap@xenotime.net, htejun@gmail.com, linux-ide@vger.kernel.org

zhao, forrest wrote:
> 1 implement ata_acpi_push_id(), which is used to set _SDD
> 2 invoke ata_acpi_push_id() in ata_dev_configure()
> 
> 
> Signed-off-by: Zhao Forrest <forrest.zhao@intel.com>

seems OK except for all the messaging -- same comments as with patch #1


