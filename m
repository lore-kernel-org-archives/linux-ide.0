From: Robert Hancock <hancockrwd@gmail.com>
Subject: Re: Problem with ICH10R and Port Multipliers
Date: Mon, 19 Oct 2009 18:46:54 -0600
Message-ID: <4ADD087E.1050005@gmail.com>
References: <4ADC9058.4090701@isp-services.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-ew0-f207.google.com ([209.85.219.207]:54605 "EHLO
	mail-ew0-f207.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751077AbZJTAqy (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 19 Oct 2009 20:46:54 -0400
Received: by ewy3 with SMTP id 3so4261757ewy.17
        for <linux-ide@vger.kernel.org>; Mon, 19 Oct 2009 17:46:58 -0700 (PDT)
In-Reply-To: <4ADC9058.4090701@isp-services.nl>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tom van Klinken / ISP Services BV <tom@isp-services.nl>
Cc: linux-ide@vger.kernel.org

On 10/19/2009 10:14 AM, Tom van Klinken / ISP Services BV wrote:
> Hi,
>
> I've got a Intel DG45FC motherboard that I would like to integrate in=
to
> a NAS system.
>
> This board has the ICH10R chipset and from what I have understood thi=
s
> chipset should support port multipliers.
> (http://www.intel.com/design/chipsets/matrixstorage_sb.htm)
>
> However it does not, it also does not show 'pmp' support in the AHCI =
flags.
>
> After contacting Intel they told me that Port Multipliers are not
> supported on their boards.
>
> Did they deliberately turn PMP support off?

According to the datasheet:

http://www.intel.com/Assets/PDF/datasheet/319973.pdf

page 538:

Supports Port Multiplier (PMS) =97 R/WO. ICH10 does not support port=20
multiplier.
NOTE: This bit must be set to 0. Port multiplier is not supported by IC=
H10.
