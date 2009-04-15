From: Robert Hancock <hancockrwd@gmail.com>
Subject: Re: LSF Papers online?
Date: Tue, 14 Apr 2009 19:39:50 -0600
Message-ID: <49E53AE6.4010803@gmail.com>
References: <49E335BA.3020103@panasas.com>	 <200904141654.24067.bzolnier@gmail.com>	 <20090414175441.5ce1f59d@lxorguk.ukuu.org.uk>	 <200904150009.06539.bzolnier@gmail.com> <1239749357.3638.3.camel@mulgrave>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-scsi-owner@vger.kernel.org>
In-Reply-To: <1239749357.3638.3.camel@mulgrave>
Sender: linux-scsi-owner@vger.kernel.org
To: linux-scsi@vger.kernel.org
Cc: linux-ide@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

James Bottomley wrote:
> 
> On a final note about the urgency of getting libata out of SCSI: Intel
> has been worrying for a while about the fatness of the SCSI/libata
> stack, and its effects on performance, especially command transmission
> via SAT, so I'm hoping they'll be supporting the effort.

I really don't see this as being a big driver for this move. If you look 
at the code that does the translation of SCSI commands to ATA commands, 
there really is not much there at all of any consequence to CPU usage. 
Compared to any kind of hardware/controller interactions I wouldn't say 
it's likely to be a significant bottleneck at all. In oprofile runs I've 
done with heavy ATA activity, the top time consumers are the interrupt 
handlers, command issue paths, code that actually is poking IO 
registers. The libata-scsi code hasn't even shown up on the radar in my 
experience.

