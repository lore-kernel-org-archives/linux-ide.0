From: Robert Hancock <hancockrwd@gmail.com>
Subject: Re: [PATCH] libata: prepare for removal of experimental tag on PATA
 drivers
Date: Sat, 14 Nov 2009 10:01:08 -0600
Message-ID: <4AFED444.5020201@gmail.com>
References: <200911141537.19068.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-yx0-f187.google.com ([209.85.210.187]:35278 "EHLO
	mail-yx0-f187.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752562AbZKNQBF (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 14 Nov 2009 11:01:05 -0500
In-Reply-To: <200911141537.19068.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

On 11/14/2009 08:37 AM, Bartlomiej Zolnierkiewicz wrote:
> Push experimental tags to host drivers that still need it so we can
> remove the "global" experimental tag for PATA drivers.
>
> I hear that some issues are being worked on but the patch reflects
> the current situation and we can trivially update status of affected
> host drivers after new fixes are merged.
>
> Signed-off-by: Bartlomiej Zolnierkiewicz<bzolnier@gmail.com>

I don't think that the problems you've mentioned fit the definition of 
the EXPERIMENTAL tag - it means that the driver isn't likely suitable 
for general use. Given that those drivers are probably used by 
significant numbers of people successfully in various distributions I 
don't think this is likely to be the case. There may be bugs but 
non-experimental does not imply bug free.
