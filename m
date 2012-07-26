From: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v2 0/2] ata: MODE SELECT implementation
Date: Thu, 26 Jul 2012 09:25:56 +0200
Message-ID: <5010F104.5080606@redhat.com>
References: <1341481235-12708-1-git-send-email-pbonzini@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1341481235-12708-1-git-send-email-pbonzini@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

Il 05/07/2012 11:40, Paolo Bonzini ha scritto:
> This is a revised version of the MODE SELECT implementation from yesterday,
> augmented with support for changeable parameter requests in MODE SENSE.
> 
> Paolo Bonzini (2):
>   ata: support MODE SENSE request for changeable parameters
>   ata: implement MODE SELECT command
> 
>  drivers/ata/libata-scsi.c |  242 +++++++++++++++++++++++++++++++++++++++++----
>  1 files changed, 221 insertions(+), 21 deletions(-)
> 

Ping, no love for these? :)

Paolo
