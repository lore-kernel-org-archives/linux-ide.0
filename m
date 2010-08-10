From: Murali N <nalajala.murali@gmail.com>
Subject: handling received FISes in SATA driver & libATA !!!
Date: Tue, 10 Aug 2010 17:27:59 +0530
Message-ID: <AANLkTimAWNFHqTL2JxqQsCZJ=FxUn7=KzRtiDdm0a8jZ@mail.gmail.com>
References: <AANLkTimdikdyj1ZkO_dNEYM4SynNpYV4jGOh7VVRN=Sn@mail.gmail.com>
	<AANLkTi=RE4hcShGA0WGaZ9Ys44FSQt_zSRvd0xJG_2D3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:49588 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752490Ab0HJL6A convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 10 Aug 2010 07:58:00 -0400
Received: by bwz3 with SMTP id 3so1824250bwz.19
        for <linux-ide@vger.kernel.org>; Tue, 10 Aug 2010 04:57:59 -0700 (PDT)
In-Reply-To: <AANLkTi=RE4hcShGA0WGaZ9Ys44FSQt_zSRvd0xJG_2D3@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide <linux-ide@vger.kernel.org>

I am posting this question here as i did't get any reply from 'kernelne=
wbies'.
Also i am not sure whether i can assist any help on SATA here for a
simple questions for my driver development!!!


Hi,
I am new to SATA driver development. Here i have few questions.

I am able to understand how SATA driver =C2=A0will send FISes to device=
=2E

I would like to know how the received FISes are handled in case of
=46ISes come from the device? These FISes are copied in a special area
whose base address is given in the "FIS base" register. I am would
like to know which driver hooks (functions) to libATA will handle the
received FISes?

i appreciate your inputs.

--
Regards,
Murali N
