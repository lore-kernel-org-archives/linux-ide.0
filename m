From: Mark Lord <liml@rtr.ca>
Subject: Re: libata-passthrough problem.
Date: Sat, 12 Nov 2005 14:56:52 -0500
Message-ID: <43764904.5030309@rtr.ca>
References: <4375CA38.9000905@superbug.demon.co.uk> <437607B5.7060605@rtr.ca> <43762CEF.2070704@pobox.com> <43764853.5050306@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([64.26.128.89]:51625 "EHLO mail.rtr.ca")
	by vger.kernel.org with ESMTP id S932487AbVKLT44 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 12 Nov 2005 14:56:56 -0500
In-Reply-To: <43764853.5050306@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <liml@rtr.ca>
Cc: Jeff Garzik <jgarzik@pobox.com>, James Courtier-Dutton <James@superbug.demon.co.uk>, linux-ide@vger.kernel.org

Speaking of which, these comments are wrong:

/**
  *      ata_tf_from_fis - Convert SATA FIS to ATA taskfile
  *      @fis: Buffer from which data will be input
  *      @tf: Taskfile to output
  *
  *      Converts a standard ATA taskfile to a Serial ATA
  *      FIS structure (Register - Host to Device).
...

The second comment should probably read something like:

  *      Converts a serial ATA FIS structure to a
  *      standard ATA taskfile.
