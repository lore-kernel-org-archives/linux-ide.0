From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Subject: Re: [PATCH] pata_isapnp: Don't use invalid I/O ports
Date: Mon, 23 Sep 2013 16:51:16 +0400
Message-ID: <52403944.7080401@cogentembedded.com>
References: <1379019689-21467-1-git-send-email-linux@rainbow-software.org> <20130922214250.GA27616@mtj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-la0-f53.google.com ([209.85.215.53]:50979 "EHLO
	mail-la0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753480Ab3IWMvW (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 23 Sep 2013 08:51:22 -0400
Received: by mail-la0-f53.google.com with SMTP id el20so2419577lab.26
        for <linux-ide@vger.kernel.org>; Mon, 23 Sep 2013 05:51:21 -0700 (PDT)
In-Reply-To: <20130922214250.GA27616@mtj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: Ondrej Zary <linux@rainbow-software.org>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

Hello.

On 23-09-2013 1:42, Tejun Heo wrote:

>> The test for 2nd I/O port validity is broken (reversed):
>> On devices with no control port, the driver attempts to use invalid port 0,
>> resulting in logs full of bad_io_access errors.
>> On devices with control port, the driver does not use it.

>> Signed-off-by: Ondrej Zary <linux@rainbow-software.org>

> Applied to libata/for-3.13.

    Why only 3.13? Isn't it a simple fix?

> Thanks.

WBR, Sergei

