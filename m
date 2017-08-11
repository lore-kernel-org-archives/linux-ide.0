From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH v2] cs5536: add support for IDE controller variant
Date: Fri, 11 Aug 2017 10:35:22 -0700
Message-ID: <20170811173522.GF3005423@devbig577.frc2.facebook.com>
References: <20170810102114.22332-1-andrey@xdel.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-qt0-f178.google.com ([209.85.216.178]:35061 "EHLO
        mail-qt0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753517AbdHKRf1 (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Fri, 11 Aug 2017 13:35:27 -0400
Received: by mail-qt0-f178.google.com with SMTP id p3so24912627qtg.2
        for <linux-ide@vger.kernel.org>; Fri, 11 Aug 2017 10:35:26 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20170810102114.22332-1-andrey@xdel.ru>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Andrey Korolyov <andrey@xdel.ru>
Cc: linux-ide@vger.kernel.org, hch@infradead.org

On Thu, Aug 10, 2017 at 01:21:14PM +0300, Andrey Korolyov wrote:
> Several legacy devices such as Geode-based Cisco ASA appliances
> and DB800 development board do possess CS5536 IDE controller
> with different PCI id than existing one. Using pata_generic is
> not always feasible as at least DB800 requires MSR quirk from
> pata_cs5536 to be used with vendor firmware.
> 
> Signed-off-by: Andrey Korolyov <andrey@xdel.ru>
> CC: stable@vger.kernel.org

Applied to libata/for-4.14.

Thanks.

-- 
tejun
