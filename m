From: Tracey Dent <tdent48227@gmail.com>
Subject: Re: [PATCH] Drivers: ata: Makefile: replace the use of <module>-objs
 with <module>-y
Date: Sun, 17 Oct 2010 06:45:33 -0400
Message-ID: <AANLkTi=39JTBALKH2zi118_a9kx_wpH2TyBY5LA6d9fe@mail.gmail.com>
References: <1287200493-2024-1-git-send-email-tdent48227@gmail.com>
	<4CBA6338.20700@teksavvy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-qw0-f46.google.com ([209.85.216.46]:51068 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932340Ab0JQKpg (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 17 Oct 2010 06:45:36 -0400
In-Reply-To: <4CBA6338.20700@teksavvy.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <kernel@teksavvy.com>
Cc: jgarzik@pobox.com, linux-kernel@vger.kernel.org, avorontsov@ru.mvista.com, linux-ide@vger.kernel.org

On 10/16/10, Mark Lord <kernel@teksavvy.com> wrote:
> On 10-10-15 11:41 PM, Tracey Dent wrote:
>> Changed<module>-objs to<module>-y in Makefile.
> ..
>> -libata-objs	:= libata-core.o libata-scsi.o libata-eh.o libata-transport.o
>> +libata-y	:= libata-core.o libata-scsi.o libata-eh.o libata-transport.o
>
>
> Why?
>

Using <module>-objs is deprecated and should now be replaced with
<module>-y(which is specified in Documentation/kbuild/makefiles.txt).

Regards,

Tracey D
