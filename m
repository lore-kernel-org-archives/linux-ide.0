From: Mark Lord <kernel@teksavvy.com>
Subject: Re: [PATCH] Drivers: ata: Makefile: replace the use of <module>-objs
 with <module>-y
Date: Sat, 16 Oct 2010 22:45:12 -0400
Message-ID: <4CBA6338.20700@teksavvy.com>
References: <1287200493-2024-1-git-send-email-tdent48227@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ironport2-out.teksavvy.com ([206.248.154.181]:26177 "EHLO
	ironport2-out.pppoe.ca" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1757251Ab0JQCpP (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 16 Oct 2010 22:45:15 -0400
In-Reply-To: <1287200493-2024-1-git-send-email-tdent48227@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tracey Dent <tdent48227@gmail.com>
Cc: jgarzik@pobox.com, linux-kernel@vger.kernel.org, avorontsov@ru.mvista.com, linux-ide@vger.kernel.org

On 10-10-15 11:41 PM, Tracey Dent wrote:
> Changed<module>-objs to<module>-y in Makefile.
..
> -libata-objs	:= libata-core.o libata-scsi.o libata-eh.o libata-transport.o
> +libata-y	:= libata-core.o libata-scsi.o libata-eh.o libata-transport.o


Why?
