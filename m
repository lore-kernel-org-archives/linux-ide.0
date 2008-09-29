From: Tejun Heo <htejun@gmail.com>
Subject: Re: SATA disk detect problem with silicon image 3132
Date: Mon, 29 Sep 2008 12:54:44 +0900
Message-ID: <48E05184.9060706@gmail.com>
References: <788014650809241914h46b153e0w6d88c2a1c8c65df3@mail.gmail.com>	 <48E032BA.10907@gmail.com> <788014650809282052q98e7b5bmd7b3bcf9ab9b4bf5@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ti-out-0910.google.com ([209.85.142.184]:54388 "EHLO
	ti-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751802AbYI2D4J (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 28 Sep 2008 23:56:09 -0400
Received: by ti-out-0910.google.com with SMTP id b6so831169tic.23
        for <linux-ide@vger.kernel.org>; Sun, 28 Sep 2008 20:56:08 -0700 (PDT)
In-Reply-To: <788014650809282052q98e7b5bmd7b3bcf9ab9b4bf5@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: khchen@synology.com
Cc: linux-ide@vger.kernel.org

KueiHuan Chen wrote:
>   Thanks for the reply. But i am curiosity about that is it possible
> for two PCI-Epress chip in the same environment, one could work fine,
> and another would has IRQ delivery problem ?

Maybe sata_mv might was in MSI mode?

-- 
tejun
